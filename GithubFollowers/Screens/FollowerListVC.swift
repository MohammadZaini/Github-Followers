//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Moe on 25/07/2024.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(with username: String)
}

class FollowerListVC: UIViewController {
    
    private enum Section { case main }
    
    var username: String!
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    private var page = 1
    private var hasMoreFollowers = true
    private var isSearching = false
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resueId)
    }
    
    
    private func configureSearchController() {
        
    let searchController                       = UISearchController()
    searchController.searchBar.placeholder     = "Search for a username"
    searchController.searchBar.delegate        = self
    searchController.searchResultsUpdater      = self
    navigationItem.searchController            = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
}
    
    
    private func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
    
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go Follow them 😀."
                    DispatchQueue.main.async { self.showEmptyStateView(message: message, in: self.view )
                    }
                }
                
                self.updateData(in: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went horrible", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resueId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    
    private func updateData(in followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


//MARK: - UI Collection View Delegate
extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > (contentHeight - screenHeight) {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower           = isSearching ? filteredFollowers[indexPath.row] : followers[indexPath.row]
        
        let destinationVC      = UserInfoVC()
        destinationVC.delegate = self
        destinationVC.username = follower.login
        
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}


//MARK: - UI Search Results Updating & UI Search Bar Delegate

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(in: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(in: followers)
    }
}


//MARK: - Follower List VC Delegate
extension FollowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(with username: String) {
        self.username = username
        title         = username
        page          = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        
        getFollowers(username: username, page: page)
    }
}
