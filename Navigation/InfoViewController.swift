//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 08.08.2023.
//
import Foundation
import UIKit

final class InfoViewController: UIViewController {
   
    private var residents: [Resident] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tatooineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
 
    private lazy var residentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizesSubviews = true
        tableView.register(ResidentsTableViewCell.self, forCellReuseIdentifier: "resident")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        self.view.addSubview(titleLabel)
        self.view.addSubview(tatooineLabel)
        self.view.addSubview(residentsTableView)
        setupConstraints()
        
        setTitle()
        getInfo()
        
    }
    
    private func setTitle() {
        let url = "https://jsonplaceholder.typicode.com/todos/3"
        NetworkService.request(for: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    self?.titleLabel.text = "Title: \(title)"
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getInfo(){
        getInfoAboutTatooine { [ weak self] result in
            
            switch result {
            case .success(let planet):
                DispatchQueue.main.async {
                    self?.tatooineLabel.text = "Период обращения планеты Татуин: \(planet.orbitalPeriod)"
                }
                planet.residents.forEach { resident in
                    self?.getInfoAboutResident(resident: resident) { resultResident in
                        switch resultResident {
                        case .success(let resident):
                            self?.residents.append(resident)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                        DispatchQueue.main.async {
                            self?.residentsTableView.reloadData()
                        }

                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func getInfoAboutTatooine(completion: @escaping (Result<Planets,NetworkError>) -> Void){
        let url = URL(string: "https://swapi.dev/api/planets/1/")!
        //let urlRequest = URLRequest(url: url)
        NetworkService.fetch(request: URLRequest(url: url), completion: completion)
    }
    
    private func getInfoAboutResident(resident: String, completion: @escaping (Result<Resident,NetworkError>) -> Void){
        let url = URL(string: resident)!
        NetworkService.fetch(request: URLRequest(url: url), completion: completion)
    }

    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            tatooineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tatooineLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tatooineLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            residentsTableView.topAnchor.constraint(equalTo: tatooineLabel.bottomAnchor, constant: 16),
            residentsTableView.leadingAnchor.constraint(equalTo: tatooineLabel.leadingAnchor),
            residentsTableView.trailingAnchor.constraint(equalTo: tatooineLabel.trailingAnchor),
            residentsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
    }
    
}

extension InfoViewController: UITableViewDelegate {}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resident", for: indexPath) as! ResidentsTableViewCell
        cell.configureCell(residents[indexPath.row])
        return cell
    }
}
