//
//  RepositoriesCoordinator.swift
//  Github-app
//
//  Created by Alex Xavier on 31/05/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

enum RepositoriesAction {
    case openExibirRepositories
    case closeFlow
    case errorScreen(errorViewControlller: ErrorViewControlller)
}

protocol RepositoriesCoordinating: AnyObject {
    func perform(action: RepositoriesAction)
    var viewController: UIViewController? { get set }
}

final class RepositoriesCoordinator {
    weak var viewController: UIViewController?
}

extension RepositoriesCoordinator: RepositoriesCoordinating {
    func perform(action: RepositoriesAction) {
        switch action {
        case .openExibirRepositories:
            viewController?.navigationController?.pushViewController(ViewController(), animated: true)
        case .closeFlow:
            viewController?.dismiss(animated: true)
        case .errorScreen(let errorViewControlller):
            viewController?.present(errorViewControlller, animated: true)
        }
    }
}

