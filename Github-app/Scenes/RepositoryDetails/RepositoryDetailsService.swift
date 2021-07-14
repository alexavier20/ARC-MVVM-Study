//
//  RepositoryDetailsService.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol RepositoryDetailsServicing {
    func fetchDetails(name: String, login: String, completion: @escaping ((Result<RepositoryDetails, APIError>) -> Void))
}

final class RepositoryDetailsService: RepositoryDetailsServicing {
    func fetchDetails(name: String, login: String, completion: @escaping ((Result<RepositoryDetails, APIError>) -> Void)) {
        let apiURL = "https://api.github.com/repos/" + login + "/" + name
        
        guard let api = URL(string: apiURL) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            guard let jsonData = data else {
                return
            }
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decoded = try decoder.decode(RepositoryDetails.self, from: jsonData)
                    
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.generic))
                }
            }
        }
        
        task.resume()
    }
}
