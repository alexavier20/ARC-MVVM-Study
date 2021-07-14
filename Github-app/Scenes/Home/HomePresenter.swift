//
//  HomePresenter.swift
//  Github-app
//
//  Created by Alex Xavier on 06/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol HomePresenting: AnyObject {
    var viewController: HomeDisplaying? { get set }
    func presentRepositories()
    func presentError()
    func presentRepositoryDetails(repositoryName: String, login: String)
    func presentEmpty()
    func presentLoading(shouldPresent: Bool)
}

final class HomePresenter {
    private let coordinator: HomeCoordinating
    weak var viewController: HomeDisplaying?
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenting {
    func presentLoading(shouldPresent: Bool) {
        viewController?.hideEmpty()
        viewController?.hideError()
        shouldPresent ? viewController?.startLoading() : viewController?.stopLoading()
    }
    
    func presentEmpty() {
        viewController?.displaySearchResponse(shouldDisplay: false)
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.hideWelcome()
        viewController?.displayEmpty()
    }
    
    func presentRepositoryDetails(repositoryName: String, login: String) {
        coordinator.perform(action: .details(repositoryName: repositoryName, login: login))
    }
    
    func presentRepositories() {
        viewController?.updateDataSource()
        viewController?.hideEmpty()
        viewController?.hideError()
        viewController?.hideWelcome()
        viewController?.displaySearchResponse(shouldDisplay: true)
    }
    
    func presentError() {
        viewController?.hideEmpty()
        viewController?.hideWelcome()
        viewController?.displayError()
    }
    
}
