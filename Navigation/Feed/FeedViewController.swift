//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 07.08.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private let viewModel = FeedViewModel()
    
    let coordinator: FeedCoordinator
    
    private lazy var buttonAction: (() -> Void) = {
        self.coordinator.push(navigationController: self.navigationController, title: self.post.title)
    }
    
    private lazy var checkWord: (() -> Void) = {
        if self.guessText.text == "" {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите предполагаемый пароль.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            self.present(alertController, animated: true)
            self.guessText.backgroundColor = .systemGray6
        } else {
            if let word = self.guessText.text {
                self.viewModel.sendWord(word: word)
            }
        }
    }
    
    private var guessText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите пароль (Secret)"
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray6
        return textField
    }()

    private lazy var feedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(CustomButton(title: "Показать пост", tapAction: buttonAction))
        stackView.addArrangedSubview(CustomButton(title: "Вторая кнопка", tapAction: buttonAction))
        stackView.addArrangedSubview(guessText)
        stackView.addArrangedSubview(CustomButton(title: "Проверить пароль", tapAction: checkWord))
        return stackView
    }()
      
    var post = BlankPost(title: "Первый пост")
    
    init(coordinator: FeedCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(feedStackView)
        title = "Лента"
        bindeViewModel()
        setupConstraints()
    }
    
    private func bindeViewModel() {
        viewModel.stateChanged = { state in
            switch state {
            case .bingo:
                self.guessText.backgroundColor = .systemGreen
            case .wrong:
                self.guessText.backgroundColor = .systemRed
            case .unkown:
                self.guessText.backgroundColor = .systemGray6
            }
        }
        
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
}
