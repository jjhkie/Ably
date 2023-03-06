//
//  ProductReview.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/25.
//

import UIKit
import XLPagerTabStrip

final class ProductReview:UIViewController, IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "리뷰")
    }
}
