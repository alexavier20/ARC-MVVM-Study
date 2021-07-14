//
//  RepositoryDetailInteractor.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol RepositoryDetailsInteracting: AnyObject {
    func initialFetch()
}

final class RepositoryDetailsInteractor {
    private let presenter: RepositoryDetailsPresenting
    private let service: RepositoryDetailsServicing
    private let repositoryName: String
    private let login: String
    
    init(presenter: RepositoryDetailsPresenting, service: RepositoryDetailsServicing, repositoryName: String, login: String) {
        self.presenter = presenter
        self.service = service
        self.repositoryName = repositoryName
        self.login = login
    }
}

extension RepositoryDetailsInteractor: RepositoryDetailsInteracting {
    func initialFetch() {
         presenter.presentLoading(shouldPresent: true)
        
        service.fetchDetails(name: repositoryName, login: login) { result in
            self.presenter.presentLoading(shouldPresent: false)
            
            switch result {
            case .success(let repositoryDetails):
                self.presenter.presentDetails(repositoryDetails: repositoryDetails)
            case .failure:
                self.presenter.presentError()                
            }
        }
    }
    
}
