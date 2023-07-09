//
//  ViewController.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    
    
    let menuView = MenuView()
    var bannersImg = [UIImage]()
    var categories: [String] = []
    var drinksCount = Int()
    var drinks: Drink?
    var presenter: MenuPresenter?
    var drinkss: [Drink] = []
    private var prevIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = menuView
        menuView.bannerCollectionView.delegate = self
        menuView.bannerCollectionView.dataSource = self
        menuView.categoryCollectionView.delegate = self
        menuView.categoryCollectionView.dataSource = self
        menuView.cocktailTableView.delegate = self
        menuView.cocktailTableView.dataSource = self
        presenter = MenuPresenter(view: self)
        presenter?.getBanners()
        presenter?.getData()
    }
    
    
}

extension MenuViewController: MenuPresenterInput {
    func presentDrinks(drinks: [Drink]) {
        self.drinkss = drinks
    }
    
    func presentDrinkModel(drink: Drink) {
        self.drinks = drink
    }
    
    func presentDrinksCount(drinksCount: Int) {
        DispatchQueue.main.async {
            self.drinksCount = drinksCount
            self.menuView.cocktailTableView.reloadData()
        }
    }
    
    func presentCategories(categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.menuView.categoryCollectionView.reloadData()
        }
    }
    
    func presentBanners(newArray: [UIImage]) {
        self.bannersImg = newArray
    }
    
}

extension MenuViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === menuView.bannerCollectionView {
            return bannersImg.count
        } else {
            return self.categories.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === menuView.bannerCollectionView  {
            let cell = menuView.bannerCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseId, for: indexPath) as! BannerCell
            cell.bannerImage.image = bannersImg[indexPath.row]
            cell.bannerImage.layer.cornerRadius = 15
            return cell
        } else {
            let cell2 = menuView.categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            cell2.layer.cornerRadius = 15
//            let cell = menuView.categoryCollectionView.cellForItem(at: IndexPath(row: 1, section: 0))
//            cell?.backgroundColor = .lightGray
            cell2.categoryName.text = self.categories[indexPath.row]
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView === menuView.categoryCollectionView {
            let category = self.categories[indexPath.row]
            let index = self.drinkss.firstIndex {
                $0.strCategory == category }
                menuView.cocktailTableView.scrollToRow(
                    at: IndexPath(row: index!, section: 0),
                    at: .top,
                    animated: false)
            }
            
           
            
        }
        }
    
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.drinksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  menuView.cocktailTableView.dequeueReusableCell(withIdentifier: CocktailTabCell.reuseID, for: indexPath) as! CocktailTabCell
        cell.backgroundColor = .white
        let drink = presenter?.presentDrinkModel(at: indexPath.row)
        cell.configure(withDrink: drink!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView === menuView.cocktailTableView else {
            return
        }
        
        if let firstIndex = menuView.cocktailTableView.indexPathsForVisibleRows?.first?.row {
            let drink = presenter?.presentDrinkModel(at: firstIndex)
            let category = drink?.strCategory
            let indexOfCategory = self.categories.firstIndex {
                $0 == category }
            menuView.categoryCollectionView.scrollToItem(
                at: IndexPath(row: indexOfCategory!, section: 0),
                at: [.centeredVertically, .centeredHorizontally],
                animated: false
            )
            if let cell = menuView.categoryCollectionView.cellForItem(
                at: IndexPath(row: prevIndex, section: 0)
                
            ) {
                cell.backgroundColor = .white
                cell.layer.cornerRadius = 15
                (cell as? CategoryCell)!.categoryName.textColor = UIColor.lightGray
            }
            
            if let cell = menuView.categoryCollectionView.cellForItem(
                at: IndexPath(row: indexOfCategory!, section: 0)
            ) {
                prevIndex = indexOfCategory!
                cell.backgroundColor = .lightGray
                cell.contentView.layer.borderWidth = 0
                (cell as? CategoryCell)!.categoryName.textColor = UIColor.black
            }
        }
        
        if scrollView.contentOffset.y >= 100 {
            menuView.categoryCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(menuView.bannerCollectionView)
                make.leading.equalTo(view).offset(16)
                make.trailing.equalTo(view)
                make.height.equalTo(32)
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.menuView.bannerCollectionView.isHidden = true
                self.view.layoutIfNeeded()
            })
            
        } else {
            menuView.categoryCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(menuView.bannerCollectionView.snp.bottom).offset(24)
                make.leading.equalTo(view).offset(16)
                make.trailing.equalTo(view)
                make.height.equalTo(32)
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.menuView.bannerCollectionView.isHidden = false
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
}








