//
//  RepositoriesPresenter.swift
//  Github-app
//
//  Created by Alex Xavier on 31/05/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol RepositoriesPresenting: AnyObject {
    var viewController: RepositoriesDisplaying? { get set }
    func presentLoading(isLoaded: Bool)
    func present(repositories: [RepositoryListResponse])
    func presentError()
}

final class RepositoriesPresenter {
    weak var viewController: RepositoriesDisplaying?
    private let coordinator: RepositoriesCoordinating
    
    init(coordinator: RepositoriesCoordinating) {
        self.coordinator = coordinator
    }
}

extension RepositoriesPresenter: RepositoriesPresenting {
    
    func presentLoading(isLoaded: Bool) {
        isLoaded ? viewController?.hideLoading() : viewController?.displayLoading()
    }
    
    func present(repositories: [RepositoryListResponse]) {
        viewController?.display(repositories: repositories)
    }
    
    func presentError() {
        let errorViewControlller = ErrorViewControlller()
        coordinator.perform(action: .errorScreen(errorViewControlller: errorViewControlller))
    }
}

