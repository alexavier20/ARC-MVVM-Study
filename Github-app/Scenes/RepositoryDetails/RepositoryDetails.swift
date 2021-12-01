//
//  RepositoryDetails.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

struct RepositoryDetails: Decodable {
    let name: String
    let htmlUrl: String
    let description: String?
    let createdAt: String   
    let language: String
    let forks: Int
    let openIssues: Int
    let owner: Owner
}

struct Owner: Decodable {
    let login: String
    let avatarUrl: String?
    let id: Int
}

