//
//  ShoppingMallViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/05.
//

import UIKit
import XLPagerTabStrip

final class ShoppingMallViewController: UIViewController,IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "쇼핑몰")
    }
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: todayLayout()).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        //$0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 0)
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
  
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}


extension ShoppingMallViewController{
    
    private func attribute(){
        
    }
    
    
    private func layout(){
        
    }
}
