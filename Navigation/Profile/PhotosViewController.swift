//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 23.08.2023.
//

import UIKit

class PhotosViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }

}
