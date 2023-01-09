//
//  TableHeader.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/21.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

final class TableHeader: UITableViewCell{
    
    private let bag = DisposeBag()
    
    private let textStack = UIStackView()
    
    private let grayText = UILabel().then{
        $0.text = "에이블리 회원이라면"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray
    }
    private let blackText = UILabel().then{
        $0.text = "누구나 무료배송!"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    
    
    private let loginButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    private let signupButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        bind()
        attribute()
        layout()
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableHeader{
    
    func bind(){
        
        //로그인 버튼 클릭 시
        loginButton.rx.tap
            .bind(onNext: {
                print("login")
            })
            .disposed(by: bag)
        
        //회원가입 버튼 클릭 시
        signupButton.rx.tap
            .bind(onNext: {
                print("sign")
            })
            .disposed(by: bag)
    }
    
    
    private func attribute(){

        textStack.axis = .vertical
        textStack.spacing = 2
        
        [loginButton,signupButton].forEach{
            //$0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            $0.setTitleColor(UIColor.gray, for: .normal)
            $0.layer.cornerRadius = 30
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        }
        
    }
    
    private func layout(){
        [grayText,blackText].forEach{
            
            textStack.addArrangedSubview($0)
        }
        
        [loginButton,signupButton].forEach{
            $0.sizeToFit()
            $0.translatesAutoresizingMaskIntoConstraints = false

        }
        
        
        

        [textStack, loginButton,signupButton].forEach{
            contentView.addSubview($0)
        }

        textStack.snp.makeConstraints{
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.leading.bottom.equalToSuperview().inset(20)
        }
        loginButton.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.top.equalTo(textStack.snp.top)
            $0.leading.equalTo(textStack.snp.trailing)
            $0.centerY.equalToSuperview()
        }
        signupButton.snp.makeConstraints{
            $0.width.equalTo(80)
            $0.top.equalTo(loginButton.snp.top)
            $0.leading.equalTo(loginButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
