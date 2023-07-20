//
//  ThrashView.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 09.07.2023.
//

import UIKit

class TrashView: UIView {

    init() {
        super.init(frame: CGRect())
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        backgroundColor = .orange
    }
    
    func setupConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
