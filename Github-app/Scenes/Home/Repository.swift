//
//  Repository.swift
//  Github-app
//
//  Created by Alex Xavier on 06/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let htmlUrl: String
    let description: String?
    let owner: Owner
}
