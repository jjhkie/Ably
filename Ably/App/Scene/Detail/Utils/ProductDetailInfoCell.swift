//
//  ProductTabCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/25.
//

import UIKit
import XLPagerTabStrip
import SnapKit


final class ProductDetailInfoCell :UICollectionViewCell{

    private let totalView = TotalTabView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductDetailInfoCell{
    private func attribute(){
  
    }
    
    private func layout(){

    }
}
