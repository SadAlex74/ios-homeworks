//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    fileprivate let data = feedPost
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileTableView)
        
        setupConstraints()
        tuneTableView()
        
    }
        
    private func setupConstraints() {
        let safeAreaGeide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: safeAreaGeide.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: safeAreaGeide.bottomAnchor),
            profileTableView.leftAnchor.constraint(equalTo: safeAreaGeide.leftAnchor),
            profileTableView.rightAnchor.constraint(equalTo: safeAreaGeide.rightAnchor)
        ])
    }
    
    private func tuneTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        
        let headerView = ProfileHeaderView()
        profileTableView.tableHeaderView = headerView
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        return UITableViewCell()
    }
    
    
}
