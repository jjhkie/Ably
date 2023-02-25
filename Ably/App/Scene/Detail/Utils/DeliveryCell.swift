//
//  DeliveryCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/20.
//

import UIKit
import SnapKit
import Then

final class DeliveryCell: UICollectionViewCell{
    
    
    ///Cell 전체 StackView
    private let deliveryInfoStack = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 10
        $0.layoutMargins = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    ///배송 방법
    private let deliveryWay = UILabel().then{
        $0.text = "배송정보"
        $0.textColor = UIColor(r: 150, g: 150, b: 150)
    }
    
    ///출발 예정
    private let scheduleddelivery = UILabel().then{
        $0.text = "출발예정 "
        $0.textColor = UIColor(r: 150, g: 150, b: 150)
    }
    
    ///배송 소요 시간
    private let deliveryTime = UILabel().then{
        $0.text = "배송 출발 이후 배송 기간은 2~3일 소요됩니다"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(r: 210, g: 210, b: 210)
    }
    
    ///free Box
    private let freeBox = BasePaddingLabel().then{
        $0.text = "에이블리는 365일 전-상품 무료 배송 !"
        $0.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DeliveryCell{
    private func attribute(){
        
    }
    
    private func layout(){
        [deliveryWay,scheduleddelivery,deliveryTime,freeBox].forEach{
            deliveryInfoStack.addArrangedSubview($0)
        }
        
        contentView.addSubview(deliveryInfoStack)
        
        deliveryInfoStack.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}
