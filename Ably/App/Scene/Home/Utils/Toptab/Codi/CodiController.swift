//
//  CodiController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/06.
//

import UIKit
import XLPagerTabStrip


final class CodiController: UIViewController,IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "코디")
    }
    
}

