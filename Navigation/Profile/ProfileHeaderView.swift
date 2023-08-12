//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var avatar = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func willMove(toSuperview newSuperview: UIView?) {
            setupUI()
    }
    
    private func setupUI() {
        setupAvatar()
    }

    private func setupAvatar() {
        addSubview(avatar)
        avatar.layer.contents = UIImage(named: "avatar")?.cgImage
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.contentMode = .scaleAspectFit
        
        let safeAreaLayoutGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100)
    ])
    }
}
