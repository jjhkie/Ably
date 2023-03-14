//
//  ShoppingMallViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/05.
//

import UIKit
import XLPagerTabStrip
import SnapKit

extension ShoppingMallViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "쇼핑몰")
    }
}

final class ShoppingMallViewController: UIViewController{
    
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: shoppingMallLayout()).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
  
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        layout()
        attribute()
    }
}




extension ShoppingMallViewController:ViewLayout{
    
    func attribute(){
        
    }
    
    
    func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
       
        //collectionView
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
