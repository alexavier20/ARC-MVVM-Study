//
//  WelcomeView.swift
//  Github-app
//
//  Created by Alex Xavier on 12/07/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

final class WelcomeView: UIView {
    
    private lazy var githubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.text = "GitHub:"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(16)
        label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
        label.text = "Where the world builds software."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "github-logo"))
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentCompressionResistancePriority(for: .vertical)
        return view
    }()
    
    func ConfigureGithubLabelConstraints() {
        NSLayoutConstraint.activate([
            githubLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            githubLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func ConfigureMessageLabelConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: githubLabel.bottomAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func ConfigureImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension WelcomeView: ViewLayout {
    func configureView() {
        backgroundColor = .systemGray6
    }
    
    func configureHierarchy() {
        addSubview(githubLabel)
        addSubview(messageLabel)
        addSubview(imageView)
    }
    
    func configureConstraints() {
        ConfigureGithubLabelConstraints()
        ConfigureMessageLabelConstraints()
        ConfigureImageViewConstraints()
    }   
    
}

