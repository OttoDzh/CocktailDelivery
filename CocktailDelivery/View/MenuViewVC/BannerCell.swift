//
//  BannerCell.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import Foundation
import SnapKit
import UIKit

class BannerCell: UICollectionViewCell {
    
    static let reuseId = "BannerCell"
    var bannerImage = UIImageView()
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        bannerImage = UIImageView(image: UIImage(named: "lobio"))
        bannerImage.contentMode = .scaleAspectFill
        bannerImage.clipsToBounds = true
        bannerImage.layer.cornerRadius = 25
    }
    
    func setupConstraints(){
        addSubview(bannerImage)
        bannerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
