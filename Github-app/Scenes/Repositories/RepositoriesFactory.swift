//
//  RepositoriesFactory.swift
//  Github-app
//
//  Created by Alex Xavier on 31/05/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

enum RepositoriesFactory {
    static func make() -> UIViewController {
        let service: RepositoriesServicing = RepositoriesService()
        let coordinator: RepositoriesCoordinating = RepositoriesCoordinator()
        let presenter: RepositoriesPresenting = RepositoriesPresenter(coordinator: coordinator)
        let interactor: RepositoriesInteracting = RepositoriesInteractor(service: service, presenter: presenter)
        let viewController = RepositoriesViewController(interactor: interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController
    }
}
