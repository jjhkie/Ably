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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MyPageCell{
    
    func setData(_ data: MyPageEnum){
        

        //셀의 공통된 설정
        
        var content = defaultContentConfiguration()
        content.text = data.contents
        content.textProperties.color = .black
        content.image = data.leadingImage
        
        //첫 번째 셀 설정
        if(data == MyPageEnum.benefit){
            content.textProperties.font = .systemFont(ofSize: 14,weight: .bold)
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            
            layer.shadowRadius = 3
            layer.shadowOffset = CGSize(width: 0, height: 0)
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.cornerRadius = 10
            
            backgroundConfig.backgroundColor = .white
            backgroundConfig.backgroundInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
            backgroundConfiguration = backgroundConfig
            
            //accessoryType 이미지를 사용하여 변경
            let image = UIImage(systemName: "chevron.forward")
            
            let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
            checkmark.image = image
            checkmark.tintColor = .gray
           // self.accessoryType = .disclosureIndicator
            self.accessoryView = checkmark
            
        }else if(data == MyPageEnum.version){
            //TODO // 최신버전 Text 추가하기 
            content.imageProperties.tintColor = .gray
        }else{
            content.imageProperties.tintColor = .gray
        }
        contentConfiguration = content
    }
    
    
}
