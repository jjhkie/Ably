//
//  CellEnum.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/09.
//

import ReusableKit

//ReusableKit Cell 정리 및 편의성 
enum CellReusable{
    //Main
    //static let mainCell = ReusableCell<
    
    //Market
    static let marketCell = ReusableCell<MarketCell>()
    
    //Zzim
    static let ZzimRoundCell = ReusableCell<ZzimRoundCell>()
    static let ZzimBoxCell = ReusableCell<ZzimBoxCell>()
    //static let ZzimHeader = Re<ZzimHeaderView>()
    //MyPage
    static let myPageHeader = ReusableCell<TableHeader>()
    static let myPageCell = ReusableCell<MyPageCell>()
    
}
