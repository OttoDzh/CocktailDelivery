//
//  MenuVCView.swift
//  CocktailDelivery
//
//  Created by Otto Dzhandzhuliya on 07.07.2023.
//

import UIKit
import SnapKit

class MenuView: UIView {
    
    let cityLabel = UILabel(text: "Moscow", font: ODFonts.boldTextFont)
    let cityButton = UIButton()
    var bannerCollectionView : UICollectionView!
    var categoryCollectionView: UICollectionView!
    let cocktailTableView = UITableView()
    

    init() {
            super.init(frame: CGRect())
            setupViews()
            setupConstraints()
        }

        func setupViews() {
            cityLabel.textColor = .black
            backgroundColor = .white
            cityButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            cityButton.tintColor = .black
            bannerCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createCompositionalLayout())
            bannerCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseId)
            categoryCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: createCompositionalLayoutforCategories())
            categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
            categoryCollectionView.backgroundColor = .white
            bannerCollectionView.backgroundColor = .white
            cocktailTableView.register(CocktailTabCell.self, forCellReuseIdentifier: CocktailTabCell.reuseID)
            cocktailTableView.backgroundColor = .white
            
           
        }
    
        func setupConstraints() {
            
            Helper.tamicOff(views: [bannerCollectionView,categoryCollectionView,cocktailTableView])
            
            let stack = UIStackView(arrangedSubviews: [cityLabel,cityButton], axis: .horizontal, spacing: 5)
            addSubview(bannerCollectionView)
            addSubview(categoryCollectionView)
            addSubview(cocktailTableView)
            addSubview(stack)
            
            stack.snp.makeConstraints { make in
                make.top.equalTo(48)
                make.left.equalTo(24)
            }
            
            cocktailTableView.snp.makeConstraints { make in
                make.top.equalTo(categoryCollectionView.snp.bottom).inset(-24)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
            }
            
            NSLayoutConstraint.activate([bannerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         bannerCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                         bannerCollectionView.heightAnchor.constraint(equalToConstant: 150),
                                         bannerCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 90)])
            NSLayoutConstraint.activate([categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 4),
                                         categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         categoryCollectionView.heightAnchor.constraint(equalToConstant: 40),
                                         categoryCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: 4)])
            
            
        }
    
    enum Section: Int,CaseIterable {
        case banners
        func desciption() -> String {
            switch self {
            case .banners:
                return "Banners"
            }
        }
        
    }
    
    enum SectionCategories: Int,CaseIterable {
        case categories
        func desciption() -> String {
            switch self {
            case .categories:
                return "Categories"
            }
        }
        
    }
    
  private  func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection in
            guard let section = Section(rawValue: section) else {fatalError("Ne polu4ilos sozdat sekciu")}
            switch section {
            case .banners:
                return self.createSections()
            }
        }
      return layout
    }
    
    private  func createCompositionalLayoutforCategories() -> UICollectionViewLayout {
          
          let layout = UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection in
              guard let section = SectionCategories(rawValue: section) else {fatalError("Ne polu4ilos sozdat sekciu")}
              switch section {
              case .categories:
                  return self.createSectionsCategories()

              }
              
          }
        return layout
      }
    
    private func createSections() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                              heightDimension: .fractionalHeight(0.9))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                               heightDimension: .fractionalWidth(0.35))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        //Section
        let spacing = CGFloat(8)
        group.interItemSpacing = .fixed(spacing)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: -12)
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
        
        
    }
    private func createSectionsCategories() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(108),
                                              heightDimension: .absolute(32))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), // ???
                                               heightDimension: .absolute(40))
        
       // let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        let groups = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let spacing = CGFloat(8)
        groups.interItemSpacing = .fixed(spacing)
        //Section
      
        let section = NSCollectionLayoutSection(group: groups)
       
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: -8, trailing: -12)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
        
        
    }
 
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}

