//
//  CustomButton.swift
//  Navigation
//
//  Created by Александр Садыков on 17.09.2023.
//

import UIKit

class CustomButton: UIButton {
    
    private var tapAction: (() -> Void)?

    convenience init(title: String? = nil, tapAction: @escaping (() -> Void)) {
        self.init(type: .custom)
        self.backgroundColor = .systemCyan
        self.setTitleColor(.systemGray6, for: .normal)
        if let title {self.setTitle(title, for: .normal)}
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.tapAction = tapAction
    }
    
    @objc private func buttonTapped(){
        tapAction?()
    }
    
}
