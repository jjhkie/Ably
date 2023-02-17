//
//  DetailModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/15.
//

import Foundation
import RxDataSources
import UIKit


enum DetailModel{
    case ProductImage(title: String, items: [Item])
    case MarketInfo(title: String, items: [Item])
}

enum DetailItemData{
    case ProductImageItem(image: UIImage)
    case MarketInfoItem(logo: UIImage, marketName: String, marketStyle: [String], marketFavorites: Int)
}

extension DetailModel: SectionModelType{
    
    
    typealias Item = DetailItemData
    
    var items: [Item] {
        switch self{
        case .ProductImage(title: _, items: let items):
            return items.map{$0}
            
        case .MarketInfo(title: _, items: let items):
            return items.map{$0}
        }
        
    }
    
    init(original: DetailModel, items: [Item]) {
        switch original{
        case let .ProductImage(title: title, items: _):
            self = .ProductImage(title: title, items: items)
        case let .MarketInfo(title: title, items: _):
            self = .MarketInfo(title: title, items: items)
        }

    }

    
    
}
