//
//  RepositoriesService.swift
//  Github-app
//
//  Created by Alex Xavier on 31/05/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import Alamofire


protocol RepositoriesServicing: AnyObject {
    func fetchRepositories(completion: @escaping (Result<RepositoryListResponse, APIError>) -> Void)
}

final class RepositoriesService: RepositoriesServicing {
    func fetchRepositories(completion: @escaping (Result<RepositoryListResponse, APIError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/alexavier20/repos") else {
            return
        }
        
        AF.request(url, method: .get).responseJSON { (result) in
            DispatchQueue.main.async {
                guard let data = result.data else {
                    completion(.failure(.genericError))
                    return
                }
               
                do {
                    let response = try JSONDecoder().decode(RepositoryListResponse.self, from: data)
                    completion(.success(response))
                } catch { completion(.failure(.genericError)) }
            }
        }
    }  
}

enum APIError: Error {
    case genericError
}
