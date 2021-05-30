//
//  APICaller.swift
//  dicodingFinalProject
//
//  Created by Albert . on 27/05/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    static let apiURL = "https://tourism-api.dicoding.dev/list"
    
    private init() {}
    
    public func getAllData(completion: @escaping (Result<[Place],Error>) -> Void) {
        guard let url = URL(string: APICaller.apiURL) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(Initial.self, from: data)
                let places = jsonData.places
                
                
                
                completion(.success(places!))
            }
            
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
