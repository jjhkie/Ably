//
//  BestController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/06.
//

import Foundation
import UIKit
import XLPagerTabStrip

final class BestController: UIViewController,IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "베스트")
    }
    
}
