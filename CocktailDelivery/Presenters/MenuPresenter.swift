//
//  MenuPresenter.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import Foundation
import UIKit

protocol MenuPresenterInput: AnyObject {
    func presentBanners(newArray: [UIImage])
    func presentCategories(categories: [String])
    func presentDrinksCount(drinksCount:Int)
    func presentDrinkModel(drink: Drink)
    func presentDrinks(drinks: [Drink])
}

class MenuPresenter {
    weak var view : MenuPresenterInput?
    private var drinks: [Drink] = []
    private var images: [UIImage] = []
    private var categories: [String] = []
    
    init(view:MenuPresenterInput){
        self.view = view
    }
    
    func getBanners() {
        let banners = [UIImage(named: "banner1")!,UIImage(named: "banner2")!]
        self.view?.presentBanners(newArray: banners)
    }
    
    func presentDrinkModel(at index: Int) -> Drink {
        self.view?.presentDrinkModel(drink: drinks[index])
        return drinks[index]
    }

    func numberOfDrinks() -> Int {
        drinks.count
    }
    
    func getData(letter:String?,activity:UIActivityIndicatorView?,tableView: UITableView?) {
        let isInternetAvailable = Reachability.isConnectedToNetwork()
        guard isInternetAvailable else {
            if let drinks = UserDefaultsHelper.getAllDrinks,
               let categories = UserDefaultsHelper.getAllCategories {
                self.drinks = drinks
                self.categories = categories
                print("hmm")
            }
            return
        }
        NetWorkService.getCocktails(letterOfCocktails: letter ?? "d") { drinks in
            if self.categories.count != 0 {
                self.categories.removeAll()
            }
            DispatchQueue.main.async {
                activity?.startAnimating()
                tableView?.isHidden = true
            }
                var drinks = drinks
                print(drinks.count)
                for i in 0..<drinks.count {
                    if let data = try? Data(contentsOf: URL(string: drinks[i].strDrinkThumb)!) {
                        drinks[i].drinkThumbImageData = data
                    }
                    if let category = drinks[i].strCategory {
                        if !self.categories.contains(category) {
                            self.categories.append(category)
                        }
                    }
                }
                self.categories = self.categories.sorted()
                self.view?.presentCategories(categories: self.categories)
                drinks = drinks.sorted(by: { $0.strCategory! < $1.strCategory! })
                UserDefaultsHelper.saveAllDrinks(allObjects: drinks)
                UserDefaultsHelper.saveAllCategories(allObjects: self.categories)
                DispatchQueue.main.async {
                    self.drinks = drinks
                    self.view?.presentDrinksCount(drinksCount: drinks.count)
                    self.view?.presentDrinks(drinks: self.drinks)
                    activity?.stopAnimating()
                    activity?.hidesWhenStopped = true
                    tableView?.isHidden = false
                   
                }
            }
    }
}

