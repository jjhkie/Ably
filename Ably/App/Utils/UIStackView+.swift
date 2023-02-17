//
//  UIStackView+.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/18.
//

import UIKit


extension UIStackView{
    
    func verticalDoubleLine(_ topValue:String,_ bottomValue:[String]){
        let topLabel = UILabel()
        let bottomLabel = UILabel()
        axis = .vertical
        [topLabel,bottomLabel].forEach{
            addArrangedSubview($0)
        }

        topLabel.text = topValue

        var tagString = ""
        for tag in bottomValue{
            tagString.isEmpty ? tagString.append("#\(tag)") :  tagString.append(" #\(tag)")

        }
        
        bottomLabel.text = tagString
        bottomLabel.textColor = .gray
        bottomLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        
        
    }
    
}
