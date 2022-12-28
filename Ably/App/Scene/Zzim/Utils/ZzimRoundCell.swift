//
//  ZzimRoundCell.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/28.
//

import UIKit
import SnapKit


final class ZzimRoundCell: UICollectionViewCell{
    
    private let stackView = UIStackView()
    //private let icon = UIImage()
    private let contents = UILabel()
    private let signButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ZzimRoundCell{
    private func attribute(){
        stackView.axis = .horizontal
        
        [contents].forEach{
            $0.text = "회원가입을 하시면 나만의\n 서랍을 만드실 수 있어요!"
            $0.numberOfLines = 0
        }

        ///Button Attribute
        [signButton].forEach{
            $0.layer.cornerRadius = 10
            $0.setTitle("회원가입", for: .normal)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.blue.cgColor
            $0.setTitleColor(UIColor.blue, for: .normal)
        }
       
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        
        layer.shadowRadius = 10
        
        var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfig.cornerRadius = 10
        backgroundConfig.backgroundColor = .white
        backgroundConfiguration = backgroundConfig
        
    }
    private func layout(){
        [contents,signButton].forEach{
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
