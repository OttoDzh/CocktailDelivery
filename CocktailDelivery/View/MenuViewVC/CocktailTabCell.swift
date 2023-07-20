//
//  CocktailTabCell.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import Foundation
import UIKit
import SnapKit

class CocktailTabCell: UITableViewCell {

 static let reuseID = "CocktailCell"
    
    let cocktailImage = UIImageView()
    let cocktailName = UILabel(text: "Margarita", font: ODFonts.titleLabelFont)
    let cocktailCategory = UILabel(text: "CategoryHere", font: ODFonts.avenirLightSmall)
    let cocktailInstruction = UITextView()
    let cocktailPrice = UIButton(title: "ot 345 rub.", bgColor: .white, textColor: .red, font: ODFonts.avenirRoman, cornerRadius: 12)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CocktailTabCell.reuseID)
        
        
        cocktailImage.image = UIImage(named: "cocktail")
        cocktailImage.layer.cornerRadius = 70
        cocktailImage.clipsToBounds = true
        cocktailImage.contentMode = .scaleAspectFill
        cocktailInstruction.text = "dskasl;dkjasjdwneqjnenwqjeqjweqwenjksdksandjhajd"
        cocktailInstruction.layer.cornerRadius = 10
        cocktailInstruction.backgroundColor = .white
       
        cocktailPrice.layer.borderColor = UIColor.red.cgColor
        cocktailPrice.layer.borderWidth = 1
        
        cocktailName.textColor = .black
        cocktailCategory.textColor = .black
        cocktailInstruction.textColor = .black
        cocktailInstruction.font = ODFonts.avenirLightSmall
       
        
        addSubview(cocktailImage)
        addSubview(cocktailName)
        addSubview(cocktailCategory)
        addSubview(cocktailInstruction)
        addSubview(cocktailPrice)
        let stack = UIStackView(arrangedSubviews: [cocktailName,cocktailCategory,cocktailInstruction], axis: .vertical, spacing: 4)
        addSubview(stack)
        
        
        cocktailInstruction.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(70)
        }
        
        cocktailImage.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.width.equalTo(140)
            make.height.equalTo(140)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(cocktailImage.snp.right).inset(-12)
        }
        
        
        cocktailPrice.snp.makeConstraints { make in
            make.bottom.equalTo(-12)
            make.right.equalTo(-12)
            make.width.equalTo(120)
            make.height.equalTo(40)
            
        }
        
    }
    
    func configure(withDrink drink: Drink) {
        cocktailName.text = drink.strDrink
        cocktailInstruction.text = drink.strInstructions
        cocktailCategory.text = "Category: \(drink.strCategory!)"
        
        if let data = drink.drinkThumbImageData,
           let image = UIImage(data: data) {
            cocktailImage.image = image
        }
    }
    
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
