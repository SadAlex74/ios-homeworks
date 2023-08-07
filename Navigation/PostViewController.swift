//
//  PostViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 07.08.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "title"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        title = titlePost
        
        let infoButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(openInfo))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc private func openInfo() {
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .flipHorizontal
        infoViewController.modalPresentationStyle = .pageSheet
        present(infoViewController, animated: true)
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
