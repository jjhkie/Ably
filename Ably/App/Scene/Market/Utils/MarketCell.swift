//
//  MarketCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/12.
//

import UIKit

final class MarketCell:UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension MarketCell{
    
    private func attribute(){
        
    }
    
    private func layout(){
        
    }
}
