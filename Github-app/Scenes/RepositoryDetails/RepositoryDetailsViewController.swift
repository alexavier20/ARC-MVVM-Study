//
//  RepositoryDetailsViewController.swift
//  Github-app
//
//  Created by Alex Xavier on 11/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

protocol RepositoryDetailsDisplaying: AnyObject {
    func loadDetails(repositoryDetails: RepositoryDetails)
    func displayError()
    func hideError()
    func startLoading()
    func stopLoading()
}

final class RepositoryDetailsViewController: UIViewController {
    private let repositoryDetailsViewModel: RepositoryDetailsViewModeling
    
    private lazy var loadingView: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .large)
        }
        return UIActivityIndicatorView(style: .medium)
    }()
    
    private lazy var errorView: UIView = ErrorView()
    
    private lazy var ownerCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var RepositoryCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:64, height:64))
        imageView.layer.masksToBounds = true
        imageView.contentCompressionResistancePriority(for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var ownerInformationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.font = label.font.withSize(18)
        label.textColor = UIColor(named: "roxo")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var idOwnerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.font = label.font.withSize(13)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor(named: "roxo")
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.font = label.font.withSize(14)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topRepositoryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var createdTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Created"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor(named: "roxo")
        
        return label
    }()
    
    private lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var forksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forks"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor(named: "roxo")
        
        return label
    }()
    
    private lazy var forksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var issuesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Issues"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor(named: "roxo")
        
        return label
    }()
    
    private lazy var issuesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var urlRepositoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor(named: "roxo")
        label.text = "URL"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var urlRepositoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var languageTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor(named: "roxo")
        label.text = "Language"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor(named: "roxo")
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(repositoryDetailsViewModel: RepositoryDetailsViewModeling) {
        self.repositoryDetailsViewModel = repositoryDetailsViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoryDetailsViewModel.initialFetch()
        buildLayout()
    }
    
    func ConfigureOwnerCardViewConstraints() {
        NSLayoutConstraint.activate([
            ownerCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            ownerCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ownerCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureAvatarImageViewConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: ownerCardView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: ownerCardView.leadingAnchor, constant: 16),
            avatarImageView.bottomAnchor.constraint(equalTo: ownerCardView.bottomAnchor, constant: -16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 64),
            avatarImageView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func ConfigureOwnerInformationViewConstraints() {
        NSLayoutConstraint.activate([
            ownerInformationView.topAnchor.constraint(equalTo: ownerCardView.topAnchor, constant: 24),
            ownerInformationView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            ownerInformationView.trailingAnchor.constraint(equalTo: ownerCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureLoginLabelConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: ownerInformationView.topAnchor, constant: 4),
            loginLabel.leadingAnchor.constraint(equalTo: ownerInformationView.leadingAnchor, constant: 0),
            loginLabel.trailingAnchor.constraint(equalTo: ownerInformationView.trailingAnchor, constant: 0)          
        ])
    }
    
    func ConfigureIdOwnerLabelConstraints() {
        NSLayoutConstraint.activate([
            idOwnerLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 4),
            idOwnerLabel.leadingAnchor.constraint(equalTo: ownerInformationView.leadingAnchor, constant: 0),
            idOwnerLabel.trailingAnchor.constraint(equalTo: ownerInformationView.trailingAnchor, constant: 0),
            idOwnerLabel.bottomAnchor.constraint(equalTo: ownerInformationView.bottomAnchor, constant: -4)
        ])
    }
    
    func ConfigureRepositoryCardViewConstraints() {
           NSLayoutConstraint.activate([
               RepositoryCardView.topAnchor.constraint(equalTo: ownerCardView.bottomAnchor, constant: 16),
               RepositoryCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               RepositoryCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               RepositoryCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
           ])
       }
    
    func ConfigureNameTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            nameTitleLabel.topAnchor.constraint(equalTo:  RepositoryCardView.topAnchor, constant: 8),
            nameTitleLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            nameTitleLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureTopRepositoryViewConstraints() {
        NSLayoutConstraint.activate([
            topRepositoryView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            topRepositoryView.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            topRepositoryView.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16),
            topRepositoryView.bottomAnchor.constraint(equalTo: urlRepositoryTitleLabel.topAnchor, constant: -16)
        ])
    }
    
    func ConfigureCreatedTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            createdTitleLabel.topAnchor.constraint(equalTo: topRepositoryView.topAnchor, constant: 0),
            createdTitleLabel.leadingAnchor.constraint(equalTo: topRepositoryView.leadingAnchor, constant: 0),
            //createdTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureCreatedLabelConstraints() {
        NSLayoutConstraint.activate([
            createdLabel.topAnchor.constraint(equalTo: createdTitleLabel.bottomAnchor, constant: 4),
            createdLabel.leadingAnchor.constraint(equalTo: topRepositoryView.leadingAnchor, constant: 0),
            //createdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureForksTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            forksTitleLabel.topAnchor.constraint(equalTo: topRepositoryView.topAnchor, constant: 0),
            forksTitleLabel.leadingAnchor.constraint(equalTo: createdLabel.trailingAnchor, constant: 24),
            //createdTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureForksLabelConstraints() {
        NSLayoutConstraint.activate([
            forksLabel.topAnchor.constraint(equalTo: forksTitleLabel.bottomAnchor, constant: 4),
            forksLabel.leadingAnchor.constraint(equalTo: createdLabel.trailingAnchor, constant: 24),
            //createdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureIssuesTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            issuesTitleLabel.topAnchor.constraint(equalTo: topRepositoryView.topAnchor, constant: 0),
            issuesTitleLabel.leadingAnchor.constraint(equalTo: forksTitleLabel.trailingAnchor, constant: 24),
            //createdTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureIssuesLabelConstraints() {
        NSLayoutConstraint.activate([
            issuesLabel.topAnchor.constraint(equalTo: forksTitleLabel.bottomAnchor, constant: 4),
            issuesLabel.leadingAnchor.constraint(equalTo: forksTitleLabel.trailingAnchor, constant: 24),
            //createdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    
    func ConfigureUrlRepositoryTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            urlRepositoryTitleLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 16),
            urlRepositoryTitleLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            urlRepositoryTitleLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureUrlRepositoryLabelConstraints() {
        NSLayoutConstraint.activate([
            urlRepositoryLabel.topAnchor.constraint(equalTo: urlRepositoryTitleLabel.bottomAnchor, constant: 4),
            urlRepositoryLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            urlRepositoryLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureLanguageTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            languageTitleLabel.topAnchor.constraint(equalTo: urlRepositoryLabel.bottomAnchor, constant: 16),
            languageTitleLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            languageTitleLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureLanguageLabelConstraints() {
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: languageTitleLabel.bottomAnchor, constant: 4),
            languageLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            languageLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureDescriptionTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 16),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16)
        ])
    }
    
    func ConfigureDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: RepositoryCardView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: RepositoryCardView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: RepositoryCardView.bottomAnchor, constant: -8)
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
}

extension RepositoryDetailsViewController: RepositoryDetailsDisplaying {
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
        
        RepositoryCardView.isHidden = true
        RepositoryCardView.removeFromSuperview()
        ownerCardView.isHidden = true
        ownerCardView.removeFromSuperview()
        
        errorView.isHidden = false
        
        ErrorViewConstraints()
    }
    
    func hideError() {
        errorView.isHidden = true
        errorView.removeFromSuperview()
    }
    
    func loadDetails(repositoryDetails: RepositoryDetails) {
        loginLabel.text = repositoryDetails.owner.login
        idOwnerLabel.text = "ID: " + String(repositoryDetails.owner.id)
        
        createdLabel.text = "20/05/2021"
        forksLabel.text = String(repositoryDetails.forks)
        issuesLabel.text = String(repositoryDetails.openIssues)
        nameLabel.text = repositoryDetails.name
        urlRepositoryLabel.text = repositoryDetails.htmlUrl
        languageLabel.text = repositoryDetails.language
        descriptionLabel.text = repositoryDetails.description
        
        let imageUrlString = repositoryDetails.owner.avatarUrl ?? ""
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }   
        
        avatarImageView.loadImge(withUrl: imageUrl)
    }
}

extension UIImageView {
    func loadImge(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


extension RepositoryDetailsViewController: ViewLayout {
    func configureView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(named: "roxo")
        navigationController?.navigationBar.tintColor = .white
    }
    
    func configureHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(ownerCardView)
        ownerCardView.addSubview(avatarImageView)
        ownerCardView.addSubview(ownerInformationView)
        ownerInformationView.addSubview(loginLabel)
        ownerInformationView.addSubview(idOwnerLabel)
        
        view.addSubview(RepositoryCardView)
        RepositoryCardView.addSubview(nameTitleLabel)
        RepositoryCardView.addSubview(nameLabel)
        RepositoryCardView.addSubview(topRepositoryView)
        topRepositoryView.addSubview(createdTitleLabel)
        topRepositoryView.addSubview(createdLabel)
        topRepositoryView.addSubview(forksTitleLabel)
        topRepositoryView.addSubview(forksLabel)
        topRepositoryView.addSubview(issuesTitleLabel)
        topRepositoryView.addSubview(issuesLabel)
        RepositoryCardView.addSubview(urlRepositoryTitleLabel)
        RepositoryCardView.addSubview(urlRepositoryLabel)
        RepositoryCardView.addSubview(languageTitleLabel)
        RepositoryCardView.addSubview(languageLabel)
        RepositoryCardView.addSubview(descriptionTitleLabel)
        RepositoryCardView.addSubview(descriptionLabel)
    }
    
    func configureConstraints() {
        ConfigureOwnerCardViewConstraints()
        ConfigureAvatarImageViewConstraints()
        ConfigureOwnerInformationViewConstraints()
        ConfigureLoginLabelConstraints()
        ConfigureIdOwnerLabelConstraints()
        
        ConfigureRepositoryCardViewConstraints()
        ConfigureNameTitleLabelConstraints()
        ConfigureNameLabelConstraints()
        ConfigureTopRepositoryViewConstraints()
        ConfigureCreatedTitleLabelConstraints()
        ConfigureCreatedLabelConstraints()
        ConfigureForksTitleLabelConstraints()
        ConfigureForksLabelConstraints()
        ConfigureIssuesTitleLabelConstraints()
        ConfigureIssuesLabelConstraints()
        ConfigureUrlRepositoryTitleLabelConstraints()
        ConfigureUrlRepositoryLabelConstraints()
        ConfigureLanguageTitleLabelConstraints()
        ConfigureLanguageLabelConstraints()
        ConfigureDescriptionTitleLabelConstraints()
        ConfigureDescriptionLabelConstraints()
    }
}
