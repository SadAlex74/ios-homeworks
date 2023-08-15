//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var avatar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "avatar")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var name: UILabel = {
        let view = UILabel()
        view.text = "Александр Садыков"
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var status: UILabel = {
        let view = UILabel()
        view.text = "В ожидании чуда..."
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var btnShowStatus: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Показать статус", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
            setupUI()
    }
    
    private func setupUI() {
        setupAvatar()
        addSubview(name)
        addSubview(status)
        setupButton()
        setupConstraints()
    }

    private func setupAvatar() {
        addSubview(avatar)
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.contentMode = .scaleAspectFit
     }
   
    private func setupButton() {
        addSubview(btnShowStatus)
        btnShowStatus.layer.cornerRadius = 4
        btnShowStatus.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        btnShowStatus.layer.shadowOffset = CGSize(width: 4, height: 4)
        btnShowStatus.layer.shadowRadius = 4
        btnShowStatus.layer.shadowColor = UIColor.black.cgColor
        btnShowStatus.layer.shadowOpacity = 0.7
    }
    
    @objc func buttonPressed() {
        print(status.text ?? "Статус пустой?!")
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            name.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 16),
            name.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            // name.heightAnchor.constraint(equalToConstant: 100)

            // status.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            status.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 16),
            status.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            status.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -18),
            
            btnShowStatus.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            btnShowStatus.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            btnShowStatus.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16),
            btnShowStatus.bottomAnchor.constraint(equalTo: btnShowStatus.topAnchor, constant: 50)
        ])
    }
}
