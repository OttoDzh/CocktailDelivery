//
//  NetWorkService.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import Foundation
class NetWorkService {
    
    static func getCocktails(completion: @escaping(_ drink: [Drink]) -> Void) {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=d"
        
        guard let url = URL(string: url) else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            do {
                let drinks = try JSONDecoder().decode(CocktailModel.self, from: data)
                print(drinks.drinks.count)
                completion(drinks.drinks)
                
            }
            catch {
                print(error)
            }
        }.resume()
        
    }
}
