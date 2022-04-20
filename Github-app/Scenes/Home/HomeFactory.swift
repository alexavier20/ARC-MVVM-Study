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
        let service: HomeServicing = HomeService()
        var homeViewModel: HomeViewModeling = HomeViewModel(service: service, coordinator: coordinator)
        let viewController = HomeViewController(homeViewModel: homeViewModel)
        
        homeViewModel.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController        
    }
}
