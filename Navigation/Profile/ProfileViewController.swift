//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray2
        button.setTitle("Вторая кнопка", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.addSubview(profileHeaderView)
        view.addSubview(secondButton)
        setupConstraints()
    }
        
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            secondButton.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            secondButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            secondButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)

        ])
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
