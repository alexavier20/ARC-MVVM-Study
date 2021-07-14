//
//  HomeService.swiftalexavier20
//  Github-app
//
//  Created by Alex Xavier on 06/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

enum APIError: Error {
    case generic
}

protocol HomeServicing {
    func fetch(login: String, completion: @escaping ((Result<[Repository], APIError>) -> Void))
}

final class HomeService: HomeServicing {
    func fetch(login: String, completion: @escaping ((Result<[Repository], APIError>) -> Void)) {
        let apiURL = "https://api.github.com/users/" + login + "/repos"
        
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
                    let decoded = try decoder.decode([Repository].self, from: jsonData)
                    
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.generic))
                }
            }
        }
        
        task.resume()
    }
}

