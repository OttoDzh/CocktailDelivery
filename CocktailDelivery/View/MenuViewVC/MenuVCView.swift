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
    let cocktailTextField = UITextField(placeholder: "Enter a letter")
    let cocktailsFindButton = UIButton(title: "Find", bgColor: .white, textColor: .white, font: ODFonts.titleLabelFont, cornerRadius: 15)
    var bannerCollectionView : UICollectionView!
    var categoryCollectionView: UICollectionView!
    let cocktailTableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
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
            cocktailTableView.separatorStyle = .none
            cocktailsFindButton.backgroundColor = .systemBlue
            cocktailTextField.textColor = .black
            let pcForCocktailTF = NSAttributedString(string: "First letter of Cocktail",attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            cocktailTextField.attributedPlaceholder = pcForCocktailTF
            activityIndicator.color = .gray
        }
    
        func setupConstraints() {
            Helper.tamicOff(views: [bannerCollectionView,categoryCollectionView,cocktailTableView])
            let stack = UIStackView(arrangedSubviews: [cocktailTextField,cocktailsFindButton], axis: .horizontal, spacing: 5)
            let cityStack = UIStackView(arrangedSubviews: [cityLabel,cityButton], axis: .horizontal, spacing: 5)
            
            addSubview(bannerCollectionView)
            addSubview(categoryCollectionView)
            addSubview(cocktailTableView)
            addSubview(stack)
            addSubview(cityStack)
            addSubview(activityIndicator)

            activityIndicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            cityStack.snp.makeConstraints { make in
                make.top.equalTo(48)
                make.left.equalTo(24)
            }
            
            stack.snp.makeConstraints { make in
                make.top.equalTo(48)
                make.left.equalTo(cityStack.snp.right).inset(-8)
            }
            
            cocktailTableView.snp.makeConstraints { make in
                make.top.equalTo(categoryCollectionView.snp.bottom).inset(-24)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
            }
            
            cocktailsFindButton.snp.makeConstraints { make in
                make.right.equalTo(snp.right).inset(4)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }
            
            bannerCollectionView.snp.makeConstraints { make in
                make.left.equalTo(snp.left)
                make.centerX.equalTo(snp.centerX)
                make.height.equalTo(150)
                make.top.equalTo(90)
            }
            
            categoryCollectionView.snp.makeConstraints { make in
                make.left.equalTo(snp.left).inset(-4)
                make.right.equalTo(snp.right)
                make.height.equalTo(40)
                make.top.equalTo(bannerCollectionView.snp.bottom).inset(-4)
            }
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

