//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 23.08.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    private lazy var photos: [UIImage] = []
    
    private let imageProcessor = ImageProcessor()
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photo")
        return view
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.title = "Photos Gallery"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupConstraints()
        setupPhoto()
        filterPhoto(filter: .fade)
    }
    
    private func setupPhoto() {
        photos = (1...20).compactMap {UIImage(named: "\($0)") }
        
    }
    
    private func filterPhoto(filter: ColorFilter) {
        let startDate = Date()
        imageProcessor.processImagesOnThread(sourceImages: photos, filter: filter, qos: .background) { [weak self] filteredPhoto in
            guard let self else { return }
            self.photos = filteredPhoto.compactMap { UIImage(cgImage: $0!) }
            print("Время обработки:  \(Date().timeIntervalSince(startDate)) секунд")
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
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

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "photo",
                for:  indexPath
        ) as? PhotosCollectionViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        cell.photoImageView.image = photos[indexPath.row]
        return cell
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: (width-36)/3, height: (width-36)/3)
    }
    
    func collectionView(
         _ collectionView: UICollectionView,
         layout collectionViewLayout: UICollectionViewLayout,
         insetForSectionAt section: Int
     ) -> UIEdgeInsets {
         UIEdgeInsets(
             top: 8,
             left: 8,
             bottom: 8,
             right: 8
         )
     }
    
}
