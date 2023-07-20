//
//  ProfileVC.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 09.07.2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    let profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = profileView
    }
}
