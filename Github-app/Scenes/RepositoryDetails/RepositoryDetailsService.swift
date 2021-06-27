//
//  RepositoryDetailService.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol RepositoryDetailsServicing {
    func fetchDetails(id: Int, completion: @escaping ((Result<Repository, APIError>) -> Void))
}

final class RepositoryDetailsService: RepositoryDetailsServicing {
    func fetchDetails(id: Int, completion: @escaping ((Result<Repository, APIError>) -> Void)) {
        
    }
}
