//
//  TableHeader.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/21.
//

import UIKit
import SnapKit
import Then

final class TableHeader: UITableViewCell{
    private let allStack = UIStackView()
    private let textStack = UIStackView()
    private let buttonStack = UIStackView()
    
    private let grayText = UILabel().then{
        $0.text = "에이블리 회원이라면"
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .gray
    }
    private let blackText = UILabel().then{
        $0.text = "누구나 무료배송!"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    private let loginButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
    }
    private let signupButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableHeader{
    private func attribute(){
        //스택뷰 설정
        [allStack,buttonStack].forEach{
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
        textStack.axis = .vertical
        
        [loginButton,signupButton].forEach{
            $0.setTitleColor(UIColor.gray, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        
    }
    
    private func layout(){
        [grayText,blackText].forEach{
            textStack.addArrangedSubview($0)
        }
        
        [loginButton,signupButton].forEach{
            buttonStack.addArrangedSubview($0)
        }
        
        [textStack,buttonStack].forEach{
            allStack.addArrangedSubview($0)
        }
        
        contentView.addSubview(allStack)
        
        allStack.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
