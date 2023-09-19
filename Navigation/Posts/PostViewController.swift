//
//  PostViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 07.08.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "title"
    var coordinator: FeedCoordinator
    
    init(coordinator: FeedCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        title = titlePost
        
        let infoButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(openInfo))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc private func openInfo() {
        coordinator.presentInfo(navigationController: self.navigationController)
    }

}
