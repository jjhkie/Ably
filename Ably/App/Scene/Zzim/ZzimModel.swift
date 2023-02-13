//
//  ZzimModel.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/23.
//

import UIKit
import RxDataSources

enum ZzimModel{
    case SignInButtonSection(title: String, items: [MainData])
    case ZzimBoxSection(title: String, items: [MainData])
}

enum MainData{
    case SignSectionItem(enabled: Bool)
    case BoxSectionItem(title: String, count: Int)
}

extension ZzimModel: SectionModelType{
    
    var items: [MainData] {
        switch self{
        case .SignInButtonSection(title: _, items: let items):
            return items.map{ $0 }
        case .ZzimBoxSection(title: _, items: let items):
            return items.map{ $0 }
        }
    }
    
    var title: String{
        switch self{
        case .SignInButtonSection(title: let title, items: _):
            return title
        case .ZzimBoxSection(title: let title, items: _):
            return title
        }
    }
    
    init(original: ZzimModel, items: [MainData]) {
        switch original{
        case let .SignInButtonSection(title: title, items: _):
            self = .SignInButtonSection(title: title, items: items)
        case let .ZzimBoxSection(title: title, items: _):
            self = .ZzimBoxSection(title: title, items: items)
        }
    }
    
    
}
