//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Moe on 25/07/2024.
//

import UIKit

class FollowerListVC: UIViewController {

    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
//        navigationController?.isNavigationBarHidden = false
        
        NetworkManager.shared.getFollowers(username: username, page: 1) { followers, error in
       
            if let error = error {
                self.presentGFAlertOnMainThread(title: "Error", message: error, buttonTitle: "Ok")
                return
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
