//
//  ZzimHeaderView.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/28.
//

import UIKit
import SnapKit
import Then

final class ZzimHeaderView: UICollectionReusableView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZzimHeaderView{
    //텍스트를 받아와 titleLabel을 설정
    func setText(_ text: String){
        titleLabel.text = text
    }
    
    private func attribute(){
       
    }
    
    private func layout(){
        self.addSubview(self.titleLabel)
        
        titleLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
