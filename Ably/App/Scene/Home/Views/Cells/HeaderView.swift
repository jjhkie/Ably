//
//  HeaderView.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/14.
//

import UIKit
import SnapKit
import Then


final class HeaderView: UICollectionReusableView{

    
    private let label = UILabel()
    let button = UIButton(type: .system).then{
        $0.setTitle("전체보기 >", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12)

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

extension HeaderView: ViewLayout{
    
    func setTitle(_ title: String){
        label.text = title
    }
    
    func attribute() {
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
      
    }
    
    func layout() {
        [label,button].forEach{
            self.addSubview($0)
        }
        label.snp.makeConstraints{
            $0.centerY.leading.equalToSuperview()
        }
        
        button.snp.makeConstraints{
            $0.centerY.trailing.equalToSuperview()
            $0.leading.equalTo(label.snp.trailing)
        }
    }
    
    
}
