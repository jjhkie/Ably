//
//  MyPageCell.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/20.
//

import UIKit


final class MyPageCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageCell{
    
    func setData(_ index: IndexPath){
        var content = defaultContentConfiguration()
        
        content.text = MyPageEnum.allCases[index.row].contents
        
        contentConfiguration = content
    }
    
    private func attribute(){
        
    }
}
