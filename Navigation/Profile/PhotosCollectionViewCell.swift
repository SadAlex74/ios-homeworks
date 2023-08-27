//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Александр Садыков on 23.08.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
   
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
        ])
        return imageView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        setupConstraints()
        //photoImageView.scalesLargeContentImage = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(with indexOfPhoto: Int) {
        photoImageView.image = UIImage(named: "\(indexOfPhoto)")
    }
 
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
