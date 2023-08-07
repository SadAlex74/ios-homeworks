//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 08.08.2023.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Alert controller", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        self.view.addSubview(actionButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        
    }
    
    
    @objc private func buttonAction() {
        let alertController = UIAlertController(title: "Demo Alert", message: "Демо сообщение в алерте", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: "OK", style: .default,  handler: { _ in
            NSLog("The \"OK\" alert occured.")})
        let secondAlertAction = UIAlertAction(title: "Oops", style: .cancel,  handler: { _ in
            NSLog("The \"Oops\" alert occured.")})
        alertController.addAction(firstAlertAction)
        alertController.addAction(secondAlertAction)
        self.present(alertController, animated: true)
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
