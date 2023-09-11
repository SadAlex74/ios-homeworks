//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit
import StorageService

final class ProfileViewController: UIViewController {
    
    fileprivate let data = feedPost
    
    private var user: User?
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileTableView)
        
#if DEBUG
        view.backgroundColor = .purple
#else
        view.backgroundColor = .white
#endif
        
        setupConstraints()
        tuneTableView()
        
    }
    
    func setupUser(_ user: User) {
        self.user = user
    }
    
    private enum CellReuseID: String {
        case post = "PostTableViewCell_ReuseID"
        case photo = "PhotoTableViewCell_ReuseID"
    }

    
    private func setupConstraints() {
        let safeAreaGeide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: safeAreaGeide.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: safeAreaGeide.bottomAnchor),
            profileTableView.leftAnchor.constraint(equalTo: safeAreaGeide.leftAnchor),
            profileTableView.rightAnchor.constraint(equalTo: safeAreaGeide.rightAnchor),
            
        ])
    }
    
    private func tuneTableView() {
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 44.0
        if #available(iOS 15.0, *) {
            profileTableView.sectionHeaderTopPadding = 0.0
        }

        let headerView = ProfileHeaderView()
        headerView.setupUser(user!)
        profileTableView.setAndLayout(headerView: headerView)
        
        profileTableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.tableHeaderView?.autoresizesSubviews = true
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseID.post.rawValue)
        profileTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseID.photo.rawValue)
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1: data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.photo.rawValue,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.post.rawValue,
                for: indexPath
            ) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            
            cell.update(data[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0  {
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
    
}


extension UITableView {
    
    func setAndLayout(headerView: UIView) {
        tableHeaderView = headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
