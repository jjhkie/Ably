//
//  MarketCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/12.
//

import UIKit
import SnapKit
import Then

final class MarketCell:UITableViewCell{
    
    let rankingText = UILabel()
    
    let profileImage = UIImageView().then{
        $0.backgroundColor = .black
    }
    
    let marketTitle = UILabel().then{
        $0.textColor = .black
    }
    
    let marketTag = UILabel().then{
        $0.textColor = .black
    }
    
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
    
    func setData(_ data: marketItem,_ index: Int){
        rankingText.text = "\(index + 1)"
        marketTitle.text = data.title
        marketTag.text = data.tag.joined()
    }
    
    private func attribute(){
        
        //accessoryView 설정
        let image = UIImage(systemName: "star")
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:self.frame.size.height, height:self.frame.size.height))
        checkmark.image = image
        checkmark.tintColor = .red
        self.accessoryView = checkmark
    }
    
    private func layout(){
        [rankingText,profileImage, marketTitle,marketTag].forEach{
            contentView.addSubview($0)
        }
        
        rankingText.snp.makeConstraints{
            $0.leading.top.equalTo(contentView.safeAreaLayoutGuide)
        }
        
//        marketTitle.snp.makeConstraints{
//            $0.trailing.leading.top.equalToSuperview()
//        }
//        marketTag.snp.makeConstraints{
//            $0.leading.equalTo(marketTitle.snp.leading)
//            $0.top.equalTo(marketTitle.snp.bottom)
//        }

    }
}
