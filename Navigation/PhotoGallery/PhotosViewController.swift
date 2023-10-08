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
    
    private var timer: Timer?
    
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
        disableTimer()
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "0.0", style: .plain, target: nil, action: nil)
    }
    
    private func setupPhoto() {
        do {
            try photos = getArrayPhoto() }
        catch {
            let alertController = UIAlertController(title: "Ошибка", message: "Изображения не найдны", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            present(alertController, animated: true)
        }
    }
    
    private func getArrayPhoto() throws -> [UIImage] {
        if Bool.random() {
            return (1...20).compactMap {UIImage(named: "\($0)") }
        } else { throw AppError.imageNotFound}
    }
    
    private func disableTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func filterPhoto(filter: ColorFilter) {
        let timerInterval = 0.1
        var filterDuration = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true, block: { _ in
            filterDuration += timerInterval
            let durStr = String( format: "%.2f sec", filterDuration)
            self.navigationItem.rightBarButtonItem?.title = durStr

        })
        imageProcessor.processImagesOnThread(sourceImages: photos, filter: filter, qos: .background) { [weak self] filteredPhoto in
            guard let self else { return }
            self.photos = filteredPhoto.compactMap { UIImage(cgImage: $0!) }
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
                self.disableTimer()
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
