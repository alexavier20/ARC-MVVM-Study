//
//  HomeFactory.swift
//  Github-app
//
//  Created by Alex Xavier on 06/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

enum HomeFactory {
    static func make() -> HomeViewController  {
        var coordinator: HomeCoordinating = HomeCoordinator()
        let presenter: HomePresenting = HomePresenter(coordinator: coordinator)
        let service: HomeServicing = HomeService()
        let interactor: HomeInteracting = HomeInteractor(presenter: presenter, service: service)
        let viewController = HomeViewController(interactor: interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController
        
    }
}
