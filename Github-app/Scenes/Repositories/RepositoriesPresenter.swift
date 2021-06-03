//
//  RepositoriesPresenter.swift
//  Github-app
//
//  Created by Alex Xavier on 31/05/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation

protocol HomePresenting: AnyObject {
    var viewController: HomeDisplaying? { get set }
    func presentLoading(isLoaded: Bool)
    func present(pokemons: [PokemonListResponse])
    func presentError()
}

final class HomePresenter {
    weak var viewController: HomeDisplaying?
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenting {
    
    func presentLoading(isLoaded: Bool) {
        isLoaded ? viewController?.hideLoading() : viewController?.displayLoading()
    }
    
    func present(pokemons: [PokemonListResponse]) {
        viewController?.display(pokemons: pokemons)
    }
    
    func presentError() {
        let errorViewControlller = ErrorViewControlller()
        coordinator.perform(action: .errorScreen(errorViewControlller: errorViewControlller))
    }
}

