//
//  BrandController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/06.
//

import Foundation
import UIKit
import XLPagerTabStrip


final class BrandController: UIViewController,IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "브랜드")
    }
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: zzimLayout()).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        //$0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 0)
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(CellReusable.commonCollectionCell)
        $0.register(CellReusable.bannerCell)
        $0.register(ZzimHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
}
