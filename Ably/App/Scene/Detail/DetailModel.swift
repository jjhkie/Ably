//
//  DetailModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/15.
//

import RxDataSources
import UIKit


enum DetailModel{
    case ProductImage(title: String, items: [Item])
    case DeliveryInfo(title: String, itmes:[Item])
    case ProductInfo(title: String, items:[Item])
}

enum DetailItemData{
    case ProductImageItem(image: UIImage,marketName: String, marketStyle: [String], marketFavorites: Int,productName: String,price: Int, sale: Int)
    case DeliveryInfoItem(syag: Bool)
    case ProductInfoItem(text: String)
}

extension DetailModel: SectionModelType{
    
    
    typealias Item = DetailItemData
    
    var items: [Item] {
        switch self{
        case .ProductImage(title: _, items: let items):
            return items
        //case .MarketInfo(title: _, items: let items):
            //return items.map{$0}
        //case .ProductInfo(title: _, items: let items):
            //return items.map{$0}
        case .DeliveryInfo(title: _, itmes: let itmes):
            return itmes.map{$0}
        case .ProductInfo(title: _ , items: let items):
            return items
        }
    }
    
    init(original: DetailModel, items: [Item]) {
        switch original{
        case let .ProductImage(title: title, items: items):
            self = .ProductImage(title: title, items: items)
        //case let .MarketInfo(title: title, items: _):
            //self = .MarketInfo(title: title, items: items)
        //case let .ProductInfo(title: title, items: _):
            //self = .ProductInfo(title: title, items: items)
        case let .DeliveryInfo(title: title, itmes: _):
            self = .DeliveryInfo(title: title, itmes: items)
        case let .ProductInfo(title: title, items: _):
            self = .ProductInfo(title: title, items: items)
        }
        
        

    }

    
    
}
