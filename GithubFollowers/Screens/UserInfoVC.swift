//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Moe on 29/07/2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    
    func didTapGithubProfile(with user: User)
    func didTapGetFollowers(with user: User)
}

class UserInfoVC: UIViewController {

    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    

    var username: String!
    
    weak var delegate: FollowerListVCDelegate!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
  
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(username: username) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureItemElements(with: user)
                }
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    
    private func configureItemElements(with user: User) {
        
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func layoutUI() {
        
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        headerView.translatesAutoresizingMaskIntoConstraints  = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        

        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            
        ])
    }
}


//MARK: - User Info VC Delegate
extension UserInfoVC: UserInfoVCDelegate {
    func didTapGithubProfile(with user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid link", message: "This link is invalid ☹️", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(with user: User) {
        delegate.didRequestFollowers(with: user.login)
        dismissVC()
    }
    
    
}
