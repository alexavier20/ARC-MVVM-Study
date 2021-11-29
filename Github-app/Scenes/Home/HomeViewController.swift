//
//  HomeViewController.swift
//  Github-app
//
//  Created by Alex Xavier on 06/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

protocol HomeDisplaying: AnyObject {
    func updateDataSource()
    func displayEmpty()
    func hideEmpty()
    func hideWelcome()
    func displaySearchResponse(shouldDisplay: Bool)
    func displayError()
    func hideError()
    func startLoading()
    func stopLoading()
}

final class HomeViewController: UIViewController {
    private let interactor: HomeInteracting
    
    private lazy var loadingView: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .large)
        }
        return UIActivityIndicatorView(style: .medium)
    }()
    
    private lazy var emptyView: UIView = EmptyView()
    private lazy var welcomeView: UIView = WelcomeView()
    private lazy var errorView: UIView = ErrorView()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.dataSource = self
        tableview.delegate = self
      
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        tableview.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        tableview.estimatedRowHeight = 80.0
        
        tableview.separatorStyle = .none
        
        return tableview
    }()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "github-logo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //interactor.initialFetch()
        buildLayout()
    }
    
    func tableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    func logoImageViewConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            //logoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            //logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    func emptyViewConstraints() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    func welcomeViewConstraints() {
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            welcomeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            welcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    func ErrorViewConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    func loadingViewConstraints() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
}

private extension HomeViewController {
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Login"
        searchController.searchBar.delegate = self
        
        if
            let searchBarContainer = searchController.searchBar.subviews.first?.subviews[1],
            let textField = searchBarContainer.subviews.first(where: { view in view is UITextField })
        {            
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 4
            textField.layer.masksToBounds = true
        }
        
        
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        interactor.clearRepositories()
        interactor.initialFetch(login: searchText)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.repositoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as? RepositoryCell else {
            return UITableViewCell()
        }
        
        let repository = interactor.getRepository(indexPath: indexPath)
        cell.setup(repository: repository)
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let indexesToRedraw = [indexPath]
              
        let backgroundview = UIView()
        backgroundview.backgroundColor = UIColor(named: "roxo3")
        cell.selectedBackgroundView = backgroundview
        
        interactor.fetchRepositoryDetails(indexPath: indexPath)
        
        tableView.reloadRows(at: indexesToRedraw, with: .fade)   
    }
}

extension HomeViewController: HomeDisplaying {
    func startLoading() {
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        loadingView.isHidden = false
        
        loadingViewConstraints()
        loadingView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
        loadingView.removeFromSuperview()
    }
    
    func displayError() {
        view.addSubview(errorView)
        view.bringSubviewToFront(errorView)
        errorView.isHidden = false
        
        ErrorViewConstraints()
    }
    
    func hideError() {
        errorView.isHidden = true
        errorView.removeFromSuperview()
    }
    
    func hideWelcome() {
        welcomeView.isHidden = true
        welcomeView.removeFromSuperview()
    }
    
    func displaySearchResponse(shouldDisplay: Bool) {
         tableView.isHidden = !shouldDisplay
    }
    
    func displayEmpty() {
        view.addSubview(emptyView)
        view.bringSubviewToFront(emptyView)
        emptyView.isHidden = false
        
        emptyViewConstraints()
    }
    
    func hideEmpty() {
        emptyView.isHidden = true
        emptyView.removeFromSuperview()
    }
    
    func updateDataSource() {
         tableView.reloadData()
    }
}

extension HomeViewController: ViewLayout {
    func configureView() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "roxo")
        appearance.titleTextAttributes = textAttributes
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Github App"
        
        setupSearchBar()
    }
    
    func configureHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(tableView)
        view.addSubview(welcomeView)
        //view.addSubview(logoImageView)
    }
    
    func configureConstraints() {
        tableViewConstraints()
        welcomeViewConstraints()
        //logoImageViewConstraints()
    }
    
}
