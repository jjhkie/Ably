//
//  TableHeader.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/21.
//

import UIKit
import SnapKit

final class TableHeader: UITableViewHeaderFooterView{
    let allStack = UIStackView()
    let textStack = UIStackView()
    let buttonStack = UIStackView()
    
    let grayText = UILabel()
    let blackText = UILabel()
    
    let loginButton = UIButton()
    let signupButton = UIButton()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
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
        
        //텍스트 설정
        grayText.text = "에이블리 회원이라면"
        grayText.font = .systemFont(ofSize: 14, weight: .bold)
        grayText.textColor = .gray
        
        blackText.text = "누구나 무료배송!"
        blackText.font = .systemFont(ofSize: 20, weight: .bold)
        blackText.textColor = .black
        
        loginButton.setTitle("로그인", for: .normal)
        signupButton.setTitle("회원가입", for: .normal)
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
