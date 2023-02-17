//
//  UIImageView+.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/18.
//

import UIKit

extension UIImageView{
    
    func roundImageView(_ value: Double){
        backgroundColor = .black
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(value / 2.0)
    }
    
}
