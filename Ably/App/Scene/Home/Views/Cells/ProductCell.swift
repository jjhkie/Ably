//
//  FirstOrderCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/14.
//

import UIKit
import SnapKit

final class ProductCell: UICollectionViewCell{
    
    
    //이미지
    private let thumbnail = UIImageView()
    
    
    //가격 및 할인
    private let priceLabel = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    //마켓 이름
    private let marketNameLabel = UILabel().then{
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12, weight: .bold)
    }
    
    //상품 이름
    private let productNameLabel = UILabel().then{
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12)
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 1
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ProductCell:ViewLayout{
    
    func setData(sale: String, price: Int, syagCheck:  Bool, marketName:  String, productName:  String){
        self.priceLabel.text = "\(sale) \(price)"
        self.marketNameLabel.text = marketName
        self.productNameLabel.text = productName
    }
    
    func attribute() {
        thumbnail.backgroundColor = .red
    }
    
    func layout() {
        [thumbnail,priceLabel,marketNameLabel,productNameLabel].forEach{
            addSubview($0)
        }
        
        thumbnail.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(thumbnail.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        marketNameLabel.snp.makeConstraints{
            $0.top.equalTo(priceLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        productNameLabel.snp.makeConstraints{
            $0.top.equalTo(marketNameLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview()
        }
    }
    
    
}
