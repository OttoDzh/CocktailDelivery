//
//  ProfileView.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 09.07.2023.
//

import UIKit

class ProfileView: UIView {

    init() {
        super.init(frame: CGRect())
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .red
    }
    
    func setupConstraints() {
        
    }

}
