//
//  ZzimModel.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/23.
//

import UIKit
import RxDataSources


struct ZzimModel{
    var header: String
    var items: [MainData]
}

struct MainData{
    let message: String
}

extension ZzimModel: SectionModelType{
    
    typealias Item = MainData
    
    init(original: ZzimModel, items: [MainData]) {
        self = original
        self.items = items
    }
    
    
}
