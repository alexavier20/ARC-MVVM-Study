//
//  HomeInteractor.swift
//  Github-app
//
//  Created by Alex Xavier on 06/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol HomeInteracting: AnyObject {
    func initialFetch(login: String)
    func repositoriesCount() -> Int
    func getRepository(indexPath: IndexPath) -> Repository
    func getAllRepository() -> [Repository]
    func fetchRepositoryDetails(indexPath: IndexPath)
    func clearRepositories()
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private let service: HomeServicing
    var repositories: [Repository] = []
    
    init(presenter: HomePresenting, service: HomeServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension HomeInteractor: HomeInteracting {
    func clearRepositories() {
        repositories = []
    }
    
    func getAllRepository() -> [Repository] {
        repositories
    }
    
    func fetchRepositoryDetails(indexPath: IndexPath) {
        let repositoryName = repositories[indexPath.row].name
        let login = repositories[indexPath.row].owner.login
        presenter.presentRepositoryDetails(repositoryName: repositoryName, login: login)
    }
    
    func getRepository(indexPath: IndexPath) -> Repository {
        repositories[indexPath.row]
    }
    
    func repositoriesCount() -> Int {
        repositories.count
    }
    
    func initialFetch(login: String) {
        presenter.presentLoading(shouldPresent: true)
        
        service.fetch(login: login, completion: { result in
            self.presenter.presentLoading(shouldPresent: false)
            
            switch result {
            case .success(let repositoriesResponse) where repositoriesResponse.count == 0:
                self.presenter.presentEmpty()
            case .success(let repositories):
                self.repositories.append(contentsOf: repositories)
                self.presenter.presentRepositories()
            case .failure:
                self.presenter.presentError()
            }
        })
    }
}
