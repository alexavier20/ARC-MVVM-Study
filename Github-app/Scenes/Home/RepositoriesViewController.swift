//
//  RepositoriesViewController.swift
//  Github-app
//
//  Created by Alex Xavier on 31/05/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

protocol RepositoriesDisplaying: AnyObject {
    func displayLoading()
    func hideLoading()
    func display(repositories: [RepositoryListResponse])
}

class RepositoriesViewController: UIViewController {
    
}

extension RepositoriesViewController: ViewLayout {
    func configureView() {
        
    }
    
    func configureHierarchy() {
        
    }
    
    func configureConstraints() {
        
    }   
}
