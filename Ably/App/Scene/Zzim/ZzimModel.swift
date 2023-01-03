//
//  ZzimModel.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/23.
//

import UIKit
import RxDataSources

enum ZzimModel{
    case SignInButtonSection(titls: String, items: [MainData])
    case ZzimBoxSection(title: String, items: [MainData])
}

enum MainData{
    case SignSectionItem(enabled: Bool)
    case BoxSectionItem(title: String, count: Int)
}

extension ZzimModel: SectionModelType{
    
    typealias Item = MainData
    
    var items: [MainData] {
        switch self{
        case .SignInButtonSection(titls: _, items: let items):
            return items.map{ $0 }
        case .ZzimBoxSection(title: _, items: let items):
            return items.map{ $0 }
        }
    }
    
    var title: String{
        switch self{
        case .SignInButtonSection(titls: let title, items: _):
            return title
        case .ZzimBoxSection(title: let title, items: _):
            return title
        }
    }
    
    init(original: ZzimModel, items: [MainData]) {
        switch original{
        case let .SignInButtonSection(titls: title, items: _):
            self = .SignInButtonSection(titls: title, items: items)
        case let .ZzimBoxSection(title: title, items: _):
            self = .ZzimBoxSection(title: title, items: items)
        }
    }
    
    
}
