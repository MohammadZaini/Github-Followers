//
//  GFAlertVC.swift
//  GithubFollowers
//
//  Created by Moe on 25/07/2024.
//

import UIKit

class GFAlertVC: UIViewController {

    let contentView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = title
        self.message     = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)

        configureContentView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    

    private func configureContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
        
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 280),
            contentView.heightAnchor.constraint(equalToConstant: 220),
        ])
        
    }
    
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    

    private func configureMessageLabel() {
        contentView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
        
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    private func configureActionButton() {
        contentView.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
