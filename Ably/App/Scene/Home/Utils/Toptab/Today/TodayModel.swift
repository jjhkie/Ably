//
//  TodayModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/21.
//

import UIKit
import RxDataSources

enum TodayModel{
    case NewYearSection(title: String, items: [TodayItemData])
    case PagerViewSection(title: String,items: [TodayItemData])
    case MenuViewSection(title: String,items: [TodayItemData])
    case FirstOrderBenefitsSection(title: String, items: [TodayItemData])
    case RecommendProductSection(title: String, items: [TodayItemData])
    case HotTenSection(title: String,items: [TodayItemData])
    case SyagRecommendProductSection(title: String, items: [TodayItemData])
    case PlusSection(title: String,items: [TodayItemData])
}

enum TodayItemData{
    case NewYearSaleItem(image: UIColor)
    case PagerViewItem(image: UIColor)
    case MenuViewItem(image: UIImage, title: String)
    case FirstOrderBenefitsItem(sale: String, price: String, syagCheck: Bool, marketName: String, ProductName: String)
    case RecommendProductItem(sale: String, price: String, syagCheck: Bool, marketName: String, ProductName: String)
    case HotTenItem(sale: String, price: String, syagCheck: Bool, marketName: String, ProductName: String, totalSale: Int)
    case SyagRecommendProductItem(sale: String, price: String, syagCheck: Bool, marketName: String, ProductName: String)
    case PlusItem(sale: String, price: String, syagCheck: Bool, marketName: String, ProductName: String, totalSale: Int)
}

extension TodayModel: SectionModelType{
    
    typealias Item = TodayItemData
    
    var items: [Item] {
        switch self{
        case .NewYearSection(title: _ ,items: let items):
            return items.map{$0}
        case .PagerViewSection(title: _, items: let items):
            return items.map{$0}
        case .MenuViewSection(title: _ ,items: let items):
            return items.map{$0}
        case .FirstOrderBenefitsSection(title: _, items: let items):
            return items.map{$0}
        case .RecommendProductSection(title: _, items: let items):
            return items.map{$0}
        case .HotTenSection(title: _, items: let items):
            return items.map{$0}
        case .SyagRecommendProductSection(title: _, items: let items):
            return items.map{$0}
        case .PlusSection(title: _, items: let items):
            return items.map{$0}
        }
    }
    
    var title: String{
        switch self{
            
        case .NewYearSection(title: let title, items: _):
            return title
        case .PagerViewSection(title: let title,items: _):
            return title
        case .MenuViewSection(title: let title,items: _):
            return title
        case .FirstOrderBenefitsSection(title: let title, items: _):
            return title
        case .RecommendProductSection(title: let title, items: _):
            return title
        case .HotTenSection(title: let title,items: _):
            return title
        case .SyagRecommendProductSection(title: let title, items: _):
            return title
        case .PlusSection(title: let title,items: _):
            return title
        }
    }
    
    init(original: TodayModel, items: [Item]) {
        switch original{
        case let .NewYearSection(title: title, items: _):
            self = .NewYearSection(title: title, items: items)
        case let .PagerViewSection(title: title, items:  _):
            self = .PagerViewSection(title: title, items: items)
        case let .MenuViewSection(title:  title, items: _):
            self = .MenuViewSection(title: title, items: items)
        case let .FirstOrderBenefitsSection(title: title, items:  _):
            self = .FirstOrderBenefitsSection(title: title, items: items)
        case let .RecommendProductSection(title:  title, items:  _):
            self = .RecommendProductSection(title: title, items: items)
        case let.HotTenSection(title:  title, items:  _):
            self = .HotTenSection(title: title, items: items)
        case let .SyagRecommendProductSection(title:  title, items:  _):
            self = .SyagRecommendProductSection(title: title, items: items)
        case let .PlusSection(title:  title, items:  _):
            self = .PlusSection(title: title, items: items)
            
        }
    }
}
