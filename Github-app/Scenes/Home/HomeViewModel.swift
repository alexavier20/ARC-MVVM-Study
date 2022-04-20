//
//  HomeViewModel.swift
//  Github-app
//
//  Created by Alex Xavier on 01/12/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol HomeViewModeling {
    var viewController: HomeDisplaying? { get set }
    func search(login: String)
    func repositoriesCount() -> Int
    func getRepository(indexPath: IndexPath) -> Repository
    func getAllRepository() -> [Repository]
    func fetchRepositoryDetails(indexPath: IndexPath)
    func clearRepositories()
}

final class HomeViewModel {
    weak var viewController: HomeDisplaying?
    private let service: HomeServicing
    private let coordinator: HomeCoordinating
    var repositories: [Repository] = []
    
    init(service: HomeServicing, coordinator: HomeCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func showLoading(shouldPresent: Bool) {
        viewController?.hideEmpty()
        viewController?.hideError()
        shouldPresent ? viewController?.startLoading() : viewController?.stopLoading()
    }
    
    func showEmpty() {
        viewController?.displaySearchResponse(shouldDisplay: false)
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.hideWelcome()
        viewController?.displayEmpty()
    }
    
    func showRepositoryDetails(repositoryName: String, login: String) {
        coordinator.perform(action: .details(repositoryName: repositoryName, login: login))
    }
    
    func showRepositories() {
        viewController?.updateDataSource()
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.hideWelcome()
        viewController?.displaySearchResponse(shouldDisplay: true)
    }
    
    func showError() {
        viewController?.hideEmpty()
        viewController?.hideWelcome()
        viewController?.displayError()
    }
}

extension HomeViewModel: HomeViewModeling {
    func clearRepositories() {
        repositories = []
    }
    
    func getAllRepository() -> [Repository] {
        repositories
    }
    
    func fetchRepositoryDetails(indexPath: IndexPath) {
        let repositoryName = repositories[indexPath.row].name
        let login = repositories[indexPath.row].owner.login
        showRepositoryDetails(repositoryName: repositoryName, login: login)
    }
    
    func getRepository(indexPath: IndexPath) -> Repository {
        repositories[indexPath.row]
    }
    
    func repositoriesCount() -> Int {
        repositories.count
    }
    
    func search(login: String) {
        showLoading(shouldPresent: true)
        
        service.fetch(login: login, completion: { result in
            self.showLoading(shouldPresent: false)
            
            switch result {
            case .success(let repositoriesResponse) where repositoriesResponse.count == 0:
                self.showEmpty()
            case .success(let repositories):
                self.repositories.append(contentsOf: repositories)
                self.showRepositories()
            case .failure:
                self.showError()
            }
        })
    }
    
}
