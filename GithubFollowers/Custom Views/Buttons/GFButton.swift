//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Moe on 24/07/2024.
//

import UIKit

class GFButton: UIButton {

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius    = 10
        titleLabel?.textColor = .white
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: . normal)
    }
}
