//
//  weatherViewModel.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 13/03/26.
//

import Foundation

class WeatherViewModel {
    
    let apiClient : Network
    
    init(apiClient: Network = Network()) {
        self.apiClient = apiClient
    }
    
    
    func fetchWeather(){
        
        guard let url = URL(string: "\(basePath)/current.json") else { return }
        
        let request = Request(url: url, httpMethod: .GET, body: nil)
        
        //apiClient.perform(request)
    }
}
