//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Moe on 25/07/2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    
    var username: String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resueId)
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        
        let screenWidth = view.bounds.width
        let padding: CGFloat = 12
        let minimumlLineSpacing: CGFloat = 10
        let availableWidth = screenWidth - (padding * 2) - (minimumlLineSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: availableWidth, height: availableWidth + 40)
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return flowLayout
    }
    
    private func getFollowers() {
        
        NetworkManager.shared.getFollowers(username: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went horrible", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
}
