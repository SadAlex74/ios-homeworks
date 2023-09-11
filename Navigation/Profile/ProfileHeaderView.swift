//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top:    10,
        left:   10,
        bottom: 10,
        right:  10
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

class ProfileHeaderView: UIView {
    
    private var user: User?
    
    private var statusText = ""
    
    private lazy var blankView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 2000))
        view.backgroundColor = .white
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var closeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "xmark.circle")
        image.layer.opacity = 0
        image.isUserInteractionEnabled = true
        let tapClose = UITapGestureRecognizer(
            target: self,
            action: #selector(tapClose)
            )
        image.addGestureRecognizer(tapClose)
         return image
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = user!.avatar
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        let tapAvatar = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAvatar)
            )
        view.addGestureRecognizer(tapAvatar)
        
        return view
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let view = UILabel()
        view.text = user!.fullName
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.text = user!.status
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Показать статус", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    private lazy var statusTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.placeholder = "Status..."
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
        
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
        addSubview(blankView)
        addSubview(avatarImageView)
        addSubview(closeImage)

        setupConstraints()
        statusTextField.becomeFirstResponder()
    }
    
    func setupUser(_ user: User) {
        self.user = user
    }
    
    @objc func statusTextChanged() {
        statusText = statusTextField.text ?? ""
    }
    
    @objc func buttonPressed() {
        if statusText != "" {
            statusLabel.text = statusText
        } else {
            let alertController = UIAlertController(title: "Изменение статуса", message: "Не указан новый статус!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.window?.rootViewController?.present(alertController, animated: true)
        }
    }
    
    @objc func tapAvatar() {
        avatarZoomIn()
    }
    
    private func closeImageSetup(){
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear){ [self] in
            closeImage.layer.opacity = 0.75
        }
       animator.startAnimation()
    }
    private func avatarZoomIn() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.avatarImageView.layer.cornerRadius = 0
        }
        animator.addAnimations { [self] in
            avatarImageView.layer.frame.size = CGSize(width: (self.window?.layer.frame.width)!, height: (self.window?.layer.frame.width)!)
            avatarImageView.center.x  = (self.window?.layer.frame.width)!/2
            avatarImageView.center.y  = (self.window?.layer.frame.height)!/2
            blankView.layer.opacity = 0.75
        }
        animator.addCompletion{ [self] finishedPosition in
            closeImageSetup()
        }
        animator.startAnimation()
    }
    
    @objc func tapClose() {
        avatarZoomOut()
    }
    
    private func avatarZoomOut() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.avatarImageView.layer.cornerRadius = 50
        }
        animator.addAnimations { [self] in
            avatarImageView.layer.frame.size = CGSize(width: 100, height: 100)
            avatarImageView.center.x  = 66
            avatarImageView.center.y  = 66
            blankView.layer.opacity = 0
            closeImage.layer.opacity = 0
        }
        animator.startAnimation()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            fullNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            statusLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
            
            setStatusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            statusTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            statusTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            closeImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
 
        ])
    }
}
