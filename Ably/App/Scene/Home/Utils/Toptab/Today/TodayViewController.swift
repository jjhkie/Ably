//
//  TodayViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/05.
//

import UIKit
import SnapKit

final class TodayViewController: UIViewController{
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 10) / 2
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        return cv
    }()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        bind()
        attribute()
        layout()
        }
}

func getLayout() -> UICollectionViewCompositionalLayout {
  UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
    switch section {
    case 0:
      let itemFractionalWidthFraction = 1.0 / 3.0 // horizontal 3개의 셀
      let groupFractionalHeightFraction = 1.0 / 4.0 // vertical 4개의 셀
      let itemInset: CGFloat = 2.5
      
      // Item
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(itemFractionalWidthFraction),
        heightDimension: .fractionalHeight(1)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
      
      // Group
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(groupFractionalHeightFraction)
      )
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      // Section
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
      return section
    default:
      let itemFractionalWidthFraction = 1.0 / 5.0 // horizontal 5개의 셀
      let groupFractionalHeightFraction = 1.0 / 4.0 // vertical 4개의 셀
      let itemInset: CGFloat = 2.5
      
      // Item
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(itemFractionalWidthFraction),
        heightDimension: .fractionalHeight(1)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
      
      // Group
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(groupFractionalHeightFraction)
      )
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      // Section
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
      return section
    }
  }
}

extension TodayViewController{
    
    func bind(){
        
    }
    
    private func attribute(){
        //CollectionView

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
        
        //collectionView
        collectionView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

//collectionView DataSource
extension TodayViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .black
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
}
