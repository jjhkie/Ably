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
    private let iconLabel = UILabel()
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
        stackView.spacing = 10
        stackView.distribution = .fill
        
        [iconLabel].forEach{
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            $0.text = "🔑"
        }
        
        [contents].forEach{
            
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            $0.text = "회원가입을 하시면 나만의\n 서랍을 만드실 수 있어요!"
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.numberOfLines = 0
        }

        var config = UIButton.Configuration.plain()
        var textAttr = AttributedString.init("회원가입")
        textAttr.font = .systemFont(ofSize: 14, weight: .bold)
        
        config.attributedTitle = textAttr
        config.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)
        config.background.strokeColor = UIColor.blue
        config.background.strokeWidth = 0.5
        
        ///Button Attribute
        signButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        signButton.configuration = config
        
//        [signButton].forEach{
//
//            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//
//            $0.setTitle("회원가입", for: .normal)
//            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//            $0.layer.cornerRadius = 10
//            $0.layer.borderWidth = 0.5
//            $0.layer.borderColor = UIColor.blue.cgColor
//            $0.setTitleColor(UIColor.blue, for: .normal)
//
//        }
//
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        
        layer.shadowRadius = 10
        
        var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfig.cornerRadius = 10
        backgroundConfig.backgroundColor = .white
        backgroundConfiguration = backgroundConfig
        
    }
    private func layout(){
        [iconLabel,contents,signButton].forEach{
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
