//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Садыков on 10.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = .lightGray
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(profileHeaderView)
        profileHeaderView.frame = view.frame
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
