//
//  CellEnum.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/09.
//

import ReusableKit
import UIKit

//ReusableKit Cell 정리 및 편의성 
enum CellReusable{
    
    static let commonCell = ReusableCell<UITableViewCell>()
    static let commonCollectionCell = ReusableCell<UICollectionViewCell>()
    //Main
    static let bannerCell = ReusableCell<BannerCell>()
    
    //Market
    static let marketCell = ReusableCell<MarketCell>()
    
    //Zzim
    static let ZzimRoundCell = ReusableCell<ZzimRoundCell>()
    static let ZzimBoxCell = ReusableCell<ZzimBoxCell>()
    //static let ZzimHeader = Re<ZzimHeaderView>()
    //MyPage
    static let myPageHeader = ReusableCell<TableHeader>()
    static let myPageCell = ReusableCell<MyPageCell>()
    
    
    //Detail
    static let ProductInfoCell = ReusableCell<ProductInfoCell>()
    static let DeliveryInfoCell = ReusableCell<DeliveryCell>()
    static let ProductDetailInfoCell = ReusableCell<ProductDetailInfoCell>()

    
}
