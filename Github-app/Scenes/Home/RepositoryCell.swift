//
//  RepositoryCell.swift
//  Github-app
//
//  Created by Alex Xavier on 07/06/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

class RepositoryCell: UITableViewCell {
    static let identifier = "RepositoryCell"
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 4
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "roxo")
        label.font = label.font.withSize(15)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(repository: Repository) {
        nameLabel.text = repository.name
        urlLabel.text = repository.htmlUrl
    }
}

extension RepositoryCell: ViewLayout {
    func configureView() {
        
    }
    
    func configureHierarchy() {
        cardView.addSubview(nameLabel)
        cardView.addSubview(urlLabel)
        addSubview(cardView)
    }
    
    func configureConstraints() {
        configureCardViewConstraints()
        configureNameLabelConstraints()
        configureUrlLabelConstraints()
    }
    
}

private extension RepositoryCell {
    func configureCardViewConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func configureNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
    }
    
    func configureUrlLabelConstraints() {
        NSLayoutConstraint.activate([
            urlLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            urlLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            urlLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            urlLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
    }
}
