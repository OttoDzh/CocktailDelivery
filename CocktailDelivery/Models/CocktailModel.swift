//
//  CocktailModel.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import Foundation

public struct CocktailModel: Codable {
    var drinks: [Drink]
}

public struct Drink: Codable {
    let strDrink: String?
    let strCategory: String?
    let strInstructions: String?
    let strDrinkThumb: String
    var drinkThumbImageData: Data?
}
