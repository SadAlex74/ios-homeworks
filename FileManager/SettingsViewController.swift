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
//        tableView.delegate = self
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
        tableView.register(cellSettings.self, forCellReuseIdentifier: "settingCell")
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellSettings(style: .default, reuseIdentifier: "settingCell")
        //cell.isUserInteractionEnabled = false
        cell.update(settingName: .sizeFile)
        return cell
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
        valueSwitch.addTarget(self, action: #selector(valueChange), for: .valueChanged)
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
        
    }
    
    private func layout() {
        addSubview(settingNameLabel)
        addSubview(settingValueSwitch)
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
    }
}

