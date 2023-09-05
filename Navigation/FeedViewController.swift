//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 07.08.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle("Показать пост", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondActionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle("Показать пост", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    private lazy var feedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(actionButton)
        stackView.addArrangedSubview(secondActionButton)
        return stackView
    }()
    
    var post = BlankPost(title: "Первый пост")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(feedStackView)
        title = "Лента"
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            feedStackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            feedStackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            feedStackView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            feedStackView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor)
       ])

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
