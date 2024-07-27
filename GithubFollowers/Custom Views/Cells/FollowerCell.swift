//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Moe on 26/07/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let resueId = "followerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        // avatar image view constraints
        NSLayoutConstraint.activate([
        
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        
        ])
        
        // username label constraints
        NSLayoutConstraint.activate([
        
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
