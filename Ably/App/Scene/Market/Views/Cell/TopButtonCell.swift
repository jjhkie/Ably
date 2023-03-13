//
//  TopButtonCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/13.
//

import UIKit
import SnapKit

final class TopButtonCell: UICollectionViewCell{
    
    var currentIndex = 0
    
    let buttonName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopButtonCell{
    func setData(_ name: String){
        buttonName.text = name
    }
    
    private func attribute(){
        buttonName.font = .systemFont(ofSize: 19, weight: .bold)
        buttonName.textColor = .lightGray
    }
    
    private func layout(){
        contentView.addSubview(buttonName)
        
        buttonName.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
