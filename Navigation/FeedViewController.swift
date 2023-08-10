//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 07.08.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle("Показать пост", for: .normal)        
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var post = Post(title: "Первый пост")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(actionButton)
        title = "Лента"
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
