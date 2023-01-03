//
//  ZzimBoxCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/02.
//

import UIKit
import SnapKit


final class ZzimBoxCell: UICollectionViewCell{
    
    private let titleLabel = UILabel()
    private let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZzimBoxCell{
    
    func setData(_ title: String, _ count: Int){
        titleLabel.text = title
        countLabel.text = "찜한 상품 \(count)개"
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        [titleLabel,countLabel].forEach{
            contentView.addSubview($0)
        }
        
        countLabel.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(countLabel.snp.top)
        }
    }
}
