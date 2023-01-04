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
