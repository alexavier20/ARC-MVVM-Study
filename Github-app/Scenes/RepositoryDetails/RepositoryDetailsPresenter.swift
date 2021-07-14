//
//  RepositoryDetailPresenter.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol RepositoryDetailsPresenting {
    var viewController: RepositoryDetailsDisplaying? { get set }
    func presentDetails(repositoryDetails: RepositoryDetails)
    func presentError()
    func presentLoading(shouldPresent: Bool)
    
}

final class RepositoryDetailsPresenter {
    private let coordinator: RepositoryDetailsCoordinating
    weak var viewController: RepositoryDetailsDisplaying?
    
    init(coordinator: RepositoryDetailsCoordinating) {
        self.coordinator = coordinator
    }
}

extension RepositoryDetailsPresenter: RepositoryDetailsPresenting {
    func presentLoading(shouldPresent: Bool) {        
        viewController?.hideError()
        shouldPresent ? viewController?.startLoading() : viewController?.stopLoading()
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    func presentDetails(repositoryDetails: RepositoryDetails) {
        viewController?.hideError()
        viewController?.loadDetails(repositoryDetails: repositoryDetails)
    }
}
