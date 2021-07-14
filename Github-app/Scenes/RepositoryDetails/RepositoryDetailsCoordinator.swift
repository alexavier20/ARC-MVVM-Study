//
//  RepositoryDetailCoordinator.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

protocol RepositoryDetailsCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class ReposiotoryDetailsCoordinator {
    weak var viewController: UIViewController?
}

extension ReposiotoryDetailsCoordinator: RepositoryDetailsCoordinating {
    
}
