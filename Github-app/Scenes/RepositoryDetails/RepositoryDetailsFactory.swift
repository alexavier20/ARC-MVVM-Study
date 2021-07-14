//
//  RepositoryDetailFactory.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

enum RepositoryDetailsFactory {
    static func make(repositoryName: String, login: String) -> RepositoryDetailsViewController  {
        let coordinator: RepositoryDetailsCoordinating = ReposiotoryDetailsCoordinator()
        var presenter: RepositoryDetailsPresenting = RepositoryDetailsPresenter(coordinator: coordinator)
        let service: RepositoryDetailsServicing = RepositoryDetailsService()
        let interactor: RepositoryDetailsInteracting = RepositoryDetailsInteractor(presenter: presenter, service: service, repositoryName: repositoryName, login: login)
        let viewController = RepositoryDetailsViewController(interactor: interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController        
    }
}
