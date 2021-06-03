//
//  RepositoryResponse.swift
//  Github-app
//
//  Created by Alex Xavier on 31/05/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

struct RepositoryResponse: Decodable {
    let name: String
    let full_name: String
}

struct RepositoryListResponse: Decodable {
    let repos: [RepositoryResponse]
}
