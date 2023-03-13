//
//  PhoneCaseController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/06.
//

import XLPagerTabStrip
import UIKit

final class PhoneCaseController:UIViewController,IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "폰케이스")
    }
    
}
