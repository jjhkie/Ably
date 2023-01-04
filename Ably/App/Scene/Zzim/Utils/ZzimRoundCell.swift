//
//  ZzimRoundCell.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/28.
//

import UIKit
import SnapKit


final class ZzimRoundCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    ///첫 번재 라인 아이콘
    private let iconLabel = UILabel().then{
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.text = "🔑"
    }
    
    ///첫 번째 라인 내용
    private let contents = UILabel().then{
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.text = "회원가입을 하시면 나만의\n 서랍을 만드실 수 있어요!"
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.numberOfLines = 0
    }
    
    /// 첫 번째 라인 버튼
    private let signButton = UIButton().then{
        
        var config = UIButton.Configuration.plain()
        var textAttr = AttributedString.init("회원가입")
        textAttr.font = .systemFont(ofSize: 14, weight: .bold)
        
        config.attributedTitle = textAttr
        config.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)
        config.background.strokeColor = UIColor.blue
        config.background.strokeWidth = 0.5
        
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.configuration = config
    }
    
    private let stackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ZzimRoundCell{
    
    //
    private func attribute(){
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        
        var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfig.cornerRadius = 10
        backgroundConfig.backgroundColor = .white
        backgroundConfiguration = backgroundConfig
        
    }
    
    //
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
