//
//  CategoryCell.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import Foundation
import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let reuseId = "CategoryCell"
    
    var categoryName = UILabel(text: "Cocktails", font: ODFonts.avenirRoman)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        categoryName.textColor = .lightGray
    }
    func setupConstraints() {
        
        addSubview(categoryName)
        
        categoryName.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.center.equalToSuperview()
        }
        
    }
}
