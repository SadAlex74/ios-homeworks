//
//  LogInViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 17.08.2023.
//

import UIKit

protocol LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String) async throws -> User
    func isValidEmail(_ email: String) -> Bool
}

class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate
    var coordinator: ProfileCoordinator
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        return view
    }()
    
    private lazy var emailTextField: TextFieldWithPadding = { [unowned self] in
        let textField = TextFieldWithPadding()
        textField.placeholder = "Email"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.delegate = self
        textField.addTarget(self, action: #selector(emailOrPasswordChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = { [unowned self] in
        let textField = TextFieldWithPadding()
        textField.placeholder = "Password (minimum 6 simbols)"
        textField.isSecureTextEntry = true
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.delegate = self
        textField.addTarget(self, action: #selector(emailOrPasswordChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var blankView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var logInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.backgroundColor = .systemGray6
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(blankView)
        stackView.addArrangedSubview(passwordTextField)
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.addTarget(self, action: #selector(logInButtonPrassed), for: .touchUpInside)
        return button
    }()
   
    init(coordinator: ProfileCoordinator, loginDelegate: LoginInspector){
        self.coordinator = coordinator
        self.loginDelegate = loginDelegate
        super.init(nibName: nil, bundle: nil)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }

    private func setupView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(logInStackView)
        contentView.addSubview(logInButton)
        #if DEBUG
        emailTextField.text = "admin@nukupi.ru"
        passwordTextField.text = "123456"
        logInButton.isEnabled = true
        #endif
    
    }
    
    private func setConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            logInStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            logInStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInStackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: logInStackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                        
            blankView.heightAnchor.constraint(equalToConstant: 0.5),
            blankView.centerYAnchor.constraint(equalTo: logInStackView.centerYAnchor)
            
            
        ])
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc func logInButtonPrassed() {
        Task{
            do {
                logInButton.isEnabled = false
                let currentUser = try await loginDelegate.checkCredentials(email: emailTextField.text!, password: passwordTextField.text!)
                coordinator.openProfile(navigationController: navigationController, user: currentUser)
            } catch {
                logInButton.isEnabled = true
                showAllert(error: .unouthorized)
            }
        }

    }
    
    @objc func emailOrPasswordChanged() {
        self.logInButton.isEnabled = loginDelegate.isValidEmail(emailTextField.text!) && passwordTextField.text!.count > 5
    }
    
    private func showAllert(error: AppError) {
        var message: String
        switch error {
        case .unouthorized:
            message = "Неверно указан пароль"
        case .userNotFound:
            message = "Пользователь не найден"
        default:
            preconditionFailure("Кроме уже обработанных вариантов других быть не может")
        }
        let alertController = UIAlertController(title: "Ошибка авторизации", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alertController, animated: true)
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
