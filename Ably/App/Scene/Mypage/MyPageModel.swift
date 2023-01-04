//
//  MyPageModel.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/22.
//

import UIKit
import RxDataSources

struct MyPageData{
    var header: String
    var items: [Item]

}

extension MyPageData: SectionModelType{
    var identity: String {
        return header
    }
    
    init(original: MyPageData, items: [MyData]) {
        self = original
        self.items = items
    }
    
    typealias Item = MyData
    
    
}

struct MyData{
    var title: String
    var image: UIImage
}
