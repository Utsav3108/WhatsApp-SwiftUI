//
//  NetworkManager.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 13/03/26.
//

import Foundation
import SwiftyJSON
/*
1. Telemetry & Debugging
- Logging
- Request Cancellation
*/

let basePath = "http://localhost:8000"

let senderId : String = "2"
let receiverId : String = "1"
let websocketPath = "ws://localhost:8000/ws/\(senderId)?token=secret"

// MARK: - Errors
enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case unauthorized // 401
    case serverError(Int) // 500 range
    case decodingFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .unauthorized: return "Your session expired. Please log in again."
        case .serverError(let code): return "Server is having trouble (Code: \(code))"
        case .decodingFailed: return "We received data, but couldn't read it."
        default: return "Something went wrong. Please try again."
        }
    }
}

// MARK: - Request / Methods
enum Method: String {
    case GET
    case PUT
    case POST
    case DELETE
}

struct Request {
    var url: URL
    var httpMethod: Method
    var body : [String : Any]?
    
    func printRequest() {
        print("=======================")
        print("Request: ", url)
        print("Body: ", body ?? [:])
        print("Method: ", httpMethod.rawValue, "\n")
        print("=======================")
    }
}

// MARK: - Network Engine
class Network {
    
    
    private struct Transaction {
        
        var request : URLRequest
        var response : Data
        var error : String?
        var timeTaken : TimeInterval
        
        func log() {
            
            print("<======>")
            request.printRequest()
            print("Response: ", JSON(response))
            print("Error: ", error ?? "None")
            print("🕥 Time taken: ", timeTaken, "s")
            print("<======>")
            
        }
        
    }
    
    static let shared = Network()
    
    let urlSession : URLSession
    
    var websocketTask : URLSessionWebSocketTask!
    
    let decoder = JSONDecoder()
    
    init(urlConfig: URLSessionConfiguration = .default) {
        self.urlSession = URLSession(configuration: urlConfig)
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            if let date = formatter.date(from: string + "Z") {
                return date
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date format"
            )
            
        }
        
        //prepareSocket()
    }
    
    func perform<T:Decodable>(_ request : Request) async -> T? {
        
        guard !Task.isCancelled else {
            print("cancelled run")
            return nil
        }
        
        var req = URLRequest(url: request.url)
        
        req.httpMethod = request.httpMethod.rawValue

        if let body = request.body {
            req.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        req.allHTTPHeaderFields = ["Content-Type": "application/json"]
        req.allHTTPHeaderFields = ["Authorization": "Bearer mysecrettoken123"]
                
        let startTime = Date.now
        
        var response : Data?
        var errorMessage : String?
        
        var result: T?
        
        do {
            
            let apiResponse = try await urlSession.data(for: req)
            
            try validate(apiResponse.1)
            
            response = apiResponse.0
            
            result = try decoder.decode(T.self, from: response!)

            
        } catch let error as CancellationError {
            print("❌ Request was explicitly cancelled.")
            errorMessage = error.localizedDescription
        } catch let error as URLError where error.code == .cancelled {
            print("❌ Network request cancelled by URLSession.")
            errorMessage = error.localizedDescription
        } catch let error as NetworkError {
            
            switch error {
            case .unauthorized:
                break
            default:
                break
            }
            
            print("Error: ", error.errorDescription ?? "-")
            errorMessage = error.localizedDescription
        } catch let error as URLError where error.code == .cannotConnectToHost {
            print("ella")
            errorMessage = error.localizedDescription

        } catch let error {
            
            errorMessage = error.localizedDescription

        }
        
        let transaction = Transaction(
            request: req,
            response: response ?? Data(),
            error: errorMessage,
            timeTaken: Date.now.timeIntervalSince(startTime)
        )
        
        transaction.log()
        
        return result
    
    }
    
    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
    
        print("Http StatusCode :", httpResponse.statusCode)
        switch httpResponse.statusCode {
        case 200...299:
            return // All good
        case 401, 404:
            throw NetworkError.unauthorized
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknown(URLError(.badServerResponse))
        }
    }
    

    func prepareSocket() {
        
        let url = URL(string: websocketPath)
        websocketTask = URLSession.shared.webSocketTask(with: url!)
        websocketTask.resume()
    }
    
    func send(payload: Data) {
        
        print("Payload: ", String(data: payload, encoding: .utf8) ?? "")
        
        let message = URLSessionWebSocketTask.Message.string(String(data: payload, encoding: .utf8) ?? "")
        websocketTask.send(message) { error in
            print("Error sending message: \(error?.localizedDescription ?? "-")")
        }
    }
  
    func listen(completion: @escaping (Result<Message, Error>) -> Void) {
        
        print("Listening...")
        
        websocketTask.receive { [self] result in
            
            print("Listened something")
            
            switch result {
            case .success(let message):
                switch message {
                case .string(let response):
                    
                    
                    
                    Task { @MainActor in
                        // 1. Decode the response as a simple String first
                        
                        let data = response.data(using: .utf8)!
                        print("Response: ", JSON(data), " - ", response)
                        
                        do {
                            let outerString = try decoder.decode(String.self, from: data)
                            
                            // 2. Convert that nested string into Data
                            if let innerData = outerString.data(using: .utf8) {
                                // 3. Now decode your actual Message model
                                let message = try decoder.decode(Message.self, from: innerData)
                                print("Success! Message: \(message.text)")
                                completion(.success(message))
                            } else {
                                print("failed to parse ; ", outerString)
                            }
                            
                        } catch {
                            print("Decoding failed: \(error)")
                        }
                        // Continue listening after handling this message
                        self.listen(completion: completion)
                    }
                    
                    
                default:
                    break
                }
                
            case .failure(let error):
                print("Lister Error : ", error.localizedDescription)
            }
            
        }
    }
         
}

extension URLRequest {
    func printRequest() {
        
        print("👾Request Log")
        print("URL: ", url?.absoluteString ?? "-")
        print("Method: ", httpMethod ?? "-")
        print("Body:", JSON(httpBody ?? Data()))
        print("HTTP Headers: ", allHTTPHeaderFields ?? [:])
        
    }
}
