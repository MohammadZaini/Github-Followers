//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Moe on 26/07/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let resueId = "followerCell"
    let avatarImage = GFAvatarImageView(frame: .zero)
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
    }
    
    private func configure() {
        
        addSubview(avatarImage)
        addSubview(usernameLabel)
        
        // avatar image view constraints
        NSLayoutConstraint.activate([
        
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor)
        
        ])
        
        // username label constraints
        NSLayoutConstraint.activate([
        
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
