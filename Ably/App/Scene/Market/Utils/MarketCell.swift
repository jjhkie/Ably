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
    
    static let imageViewSize = 50.0
    
    let marketInfoView = UIStackView().then{
        $0.axis = .vertical
    }
    
    let buttonInfoView = UIStackView().then{
        $0.axis = .horizontal
    }
    
    //랭킹 텍스트
    let rankingText = UILabel()
    
    //프로필 이미지
    let profileImage = UIImageView().then{
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = CGFloat(imageViewSize / 2.0)
    }
    
    //마켓 이름
    let marketTitle = UILabel().then{
        $0.textColor = .black
    }
    
    // 마켓 태그
    let marketTag = UILabel().then{
        $0.textColor = .black
    }
    
    // 우측 버튼
    let favoriteButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .favorite)        
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
        ///Ranking Text
        if(index < 3){
            rankingText.textColor = .red
        }
        rankingText.text = "\(index + 1)"
        
        marketTitle.text = data.title
        
        var tagString = ""
        for tag in data.tag{
            tagString.isEmpty ? tagString.append("#\(tag)") :  tagString.append(" #\(tag)")
            
        }
        marketTag.text = tagString
        marketTag.textColor = .gray
        marketTag.font = .systemFont(ofSize: 12, weight: .bold)
    }
    
    private func attribute(){
    }
    
    private func layout(){
        
        //스택 [텍스트 뷰 추가]
        [marketTitle,marketTag].forEach{
            marketInfoView.addArrangedSubview($0)
        }

        //뷰 추가
        [rankingText,profileImage, marketInfoView, favoriteButton].forEach{
            contentView.addSubview($0)
        }
        
        rankingText.snp.makeConstraints{
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        profileImage.snp.makeConstraints{
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(rankingText.snp.trailing).offset(15)
            $0.trailing.equalTo(marketInfoView.snp.leading).offset(-15)
            $0.width.equalTo(MarketCell.imageViewSize)
            $0.height.equalTo(MarketCell.imageViewSize)
        }
        
        marketInfoView.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.top)
            $0.bottom.equalTo(profileImage.snp.bottom)
            $0.leading.equalTo(profileImage.snp.trailing)
        }
        
        favoriteButton.snp.makeConstraints{
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }


    }
}
