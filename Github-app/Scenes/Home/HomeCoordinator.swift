//
//  HomeCoordinator.swift
//  Github-app
//
//  Created by Alex Xavier on 06/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

enum HomeAction {
    case details(repositoryName: String, login: String)
}

protocol HomeCoordinating {
    var viewController: UIViewController? { get set }
    func perform(action: HomeAction)
}

final class HomeCoordinator {
     weak var viewController: UIViewController?
}

extension HomeCoordinator: HomeCoordinating {
    func perform(action: HomeAction) {
        switch action {
        case .details(let repositoryName, let login):
            let detailsViewController = RepositoryDetailsFactory.make(repositoryName: repositoryName, login: login)
            viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
        default:
            break
        }
    }
}
