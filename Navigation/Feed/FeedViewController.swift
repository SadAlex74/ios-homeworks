//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 07.08.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private lazy var buttonAction: (() -> Void) = {
        let postViewController = PostViewController()
        postViewController.titlePost = self.post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private lazy var checkWord: (() -> Void) = {
        if self.guessText.text == "" {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите предполагаемый пароль.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            self.present(alertController, animated: true)

        } else {
            self.guessText.backgroundColor = FeedModel.shared.check(word: self.guessText.text!) ? .systemGreen : .systemRed
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
}
