//
//  ErrorView.swift
//  Github-app
//
//  Created by Alex Xavier on 13/07/21.
//  Copyright © 2021 Alex Xavier. All rights reserved.
//

import Foundation
import UIKit

final class ErrorView: UIView {
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "warning"))
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentCompressionResistancePriority(for: .vertical)
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = label.font.withSize(16)
           label.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.66, alpha: 1.0)
           label.text = "Unexpected error."
           label.numberOfLines = 0
           return label
       }()
    
    func ConfigureMessageLabelConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            //messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    func ConfigureImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension ErrorView: ViewLayout {
    func configureView() {
        backgroundColor = .systemGray6
    }
    
    func configureHierarchy() {
        addSubview(messageLabel)
         addSubview(imageView)
    }
    
    func configureConstraints() {
        ConfigureMessageLabelConstraints()
        ConfigureImageViewConstraints()
    }
    
}
