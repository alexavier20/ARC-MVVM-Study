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
      
        let service: RepositoryDetailsServicing = RepositoryDetailsService()
        let viewModel: RepositoryDetailsViewModeling = RepositoryDetailsViewModel(service: service, repositoryName: repositoryName, login: login)
        let viewController = RepositoryDetailsViewController(repositoryDetailsViewModel: viewModel)
        
        viewModel.viewController = viewController
        
        return viewController        
    }
}
