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
        self.backgroundColor = .white
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageCell{
    
    func setData(_ row: Int,_ data: MyPageData ){
        
        //TODO Cell Padding 값 주기
        
        //첫 번째 셀 설정
        if(row == 0){
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.5
            
            layer.shadowRadius = 10
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.cornerRadius = 10
            backgroundConfig.backgroundColor = .white
            backgroundConfig.backgroundInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
            backgroundConfiguration = backgroundConfig
            self.accessoryType = .disclosureIndicator
        }
        
        //셀의 공통된 설정
        var content = defaultContentConfiguration()
        content.text = data.title
        content.textProperties.color = .black
        ///content.textProperties.font = .systemFont(ofSize: 10) //font Size
        content.image = data.image
        content.imageProperties.tintColor = .gray
        contentConfiguration = content
        
    }
    
    private func attribute(){
        
    }
}
