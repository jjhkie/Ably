//
//  MarketInfoCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/17.
//


import UIKit
import Then
import SnapKit

final class MarketInfoCell:UICollectionViewCell{
    
    let marketImage = UIImageView().then{
        $0.roundImageView(50.0)
    }
    
    let marketInfoView = UIStackView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MarketInfoCell{
    
    func setData(_ marketName: String , _ marketStyle: [String]){
        marketInfoView.verticalDoubleLine(marketName, marketStyle)
    }
    private func attribute(){
        
        
        
    }
    
    private func layout(){
        [marketImage,marketInfoView].forEach{
            contentView.addSubview($0)
        }
        
        marketImage.snp.makeConstraints{
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.width.equalTo(50)
        }
        
        marketInfoView.snp.makeConstraints{
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(marketImage.snp.trailing)
        }
    }
}

