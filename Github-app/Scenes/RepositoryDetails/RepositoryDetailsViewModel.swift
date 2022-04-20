//
//  RepositoryDetailsViewModel.swift
//  Github-app
//
//  Created by Alex Xavier on 30/11/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol RepositoryDetailsViewModeling : AnyObject {
    var viewController: RepositoryDetailsDisplaying? { get set }
    func initialFetch()
}

final class RepositoryDetailsViewModel {
    weak var viewController: RepositoryDetailsDisplaying?
    private let service: RepositoryDetailsServicing
    private let repositoryName: String
    private let login: String
    
    init(service: RepositoryDetailsServicing, repositoryName: String, login: String) {
        self.service = service
        self.repositoryName = repositoryName
        self.login = login
    }
    
    private func showLoading(shouldPresent: Bool) {
        viewController?.hideError()
        shouldPresent ? viewController?.startLoading() : viewController?.stopLoading()
    }
    
    private func showError() {
        viewController?.displayError()
    }
    
    private func showDetails(repositoryDetails: RepositoryDetails) {
        viewController?.hideError()
        viewController?.loadDetails(repositoryDetails: repositoryDetails)
    }
}

extension RepositoryDetailsViewModel: RepositoryDetailsViewModeling {
    func initialFetch() {
        showLoading(shouldPresent: true)
       
       service.fetchDetails(name: repositoryName, login: login) { result in
           self.showLoading(shouldPresent: false)
           
           switch result {
           case .success(let repositoryDetails):
               self.showDetails(repositoryDetails: repositoryDetails)
           case .failure:
               self.showError()
           }
       }
    }
    
    
}
