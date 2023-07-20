//
//  MainTabBar.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 09.07.2023.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupViews()
    }
    
    func generateTabBar() {
        viewControllers = [
            generateNavVc(vc: MenuViewController(), title: "Menu", image: UIImage(systemName: "menucard")),
            generateNavVc(vc: TrashVC(), title: "Trash", image: UIImage(systemName: "trash")),
            generateNavVc(vc: ProfileVC(), title: "Profile", image: UIImage(systemName: "person.fill"))
            ]
    }
    
    private func generateNavVc(vc: UIViewController,title: String,image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }

    private func setupViews() {
        tabBar.backgroundColor = .lightGraySelf
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .lightGray
    }
}
