//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Александр Садыков on 04.11.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func layout() {
        view.addSubview(tableView)
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = cellSettings(style: .default, reuseIdentifier: nil)
            cell.update(settingName: .sortingFile)
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell = cellSettings(style: .default, reuseIdentifier: nil)
            cell.update(settingName: .sizeFile)
            cell.isUserInteractionEnabled = false
            return cell
        default:
            let cell = changePasswordCell(style: .default, reuseIdentifier: nil)
            //cell.isUserInteractionEnabled = false
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let vc = LoginViewController(mode: .changePassword, coordinator: MainCoordinator())
            present(vc, animated: true)
        }
    }
}

final class cellSettings: UITableViewCell {
    
    private var settingName = ""
    
    private lazy var settingNameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingValueSwitch: UISwitch = {
        var valueSwitch = UISwitch()
        valueSwitch.translatesAutoresizingMaskIntoConstraints = false
        return valueSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func valueChange() {
        print("change value")
    }
    
    private func layout() {
        addSubview(settingNameLabel)
        addSubview(settingValueSwitch)
        settingValueSwitch.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        NSLayoutConstraint.activate([
            settingValueSwitch.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            settingNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            settingNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            settingValueSwitch.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            
        ])
    }
    func update(settingName: String){
        self.settingName = settingName
        self.settingNameLabel.text = settingName
        self.settingValueSwitch.isOn = UserDefaults.standard.bool(forKey: settingName)
    }
}

final class changePasswordCell: UITableViewCell {
    private lazy var changePasswordButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change password", for: .normal)
        button.backgroundColor = .purple
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(changePasswordButton)
        changePasswordButton.addTarget(self, action: #selector(changePasswordAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            changePasswordButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            changePasswordButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            changePasswordButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @objc private func changePasswordAction() {
        //let vc = LoginViewController(mode: .changePassword, coordinator: MainCoordinator())
        
    }

}
