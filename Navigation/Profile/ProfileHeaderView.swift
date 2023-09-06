//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit
import SnapKit

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
    
    private var statusText = ""
    
    private lazy var blankView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 2000))
        view.backgroundColor = .white
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var closeImage: UIImageView = {
        let image = UIImageView()
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
        view.image = UIImage(named: "avatar")
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
        view.text = "Александр Садыков"
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.text = "В ожидании чуда..."
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Показать статус", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        fullNameLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.snp.top).offset(27)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
        }
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(16)
        }
        setStatusButton.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
        statusTextField.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.height.equalTo(40)
        }
        closeImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }

    }
}
