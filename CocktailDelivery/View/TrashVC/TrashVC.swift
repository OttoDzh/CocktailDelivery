//
//  ThrashVC.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 09.07.2023.
//

import UIKit

class TrashVC: UIViewController {
    
    let thrashView = TrashView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = thrashView
    }
    

}
