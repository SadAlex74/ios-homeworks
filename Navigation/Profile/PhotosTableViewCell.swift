//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Александр Садыков on 23.08.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func getImageView(name: String) -> UIImageView {
        let image  = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: name)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1)
        ])
        return image
    }
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 8
        view.addArrangedSubview(getImageView(name: "\(Int.random(in: 1...20))"))
        view.addArrangedSubview(getImageView(name: "\(Int.random(in: 1...20))"))
        view.addArrangedSubview(getImageView(name: "\(Int.random(in: 1...20))"))
        view.addArrangedSubview(getImageView(name: "\(Int.random(in: 1...20))"))
        view.distribution = .fillEqually
        view.alignment = .fill
        return view
    }()
   
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.right")
        return image
    }()
    
    private func tuneView() {
        addSubview(photoLabel)
        addSubview(stackView)
        addSubview(arrowImageView)
        setConstraints()
    }
    private func setConstraints() {
        let safeAreaGuide = safeAreaLayoutGuide
        let heightImage = (self.frame.width - 48) / 4
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            arrowImageView.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            stackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stackView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: heightImage)
            
        ])
    }
    
}
