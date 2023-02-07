//
//  UIButton+.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/05.
//

import UIKit

extension UIButton.Configuration{
    
    enum ButtonStyle{
        case basic
        case favorite
        
        var foregroundColor: UIColor?{
            switch self{
            case .basic:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            case .favorite:
                return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            }
        }
    }
    
    static func buttonStyle(style: ButtonStyle) -> UIButton.Configuration{
        var configuration = UIButton.Configuration.plain()
        
        //TODO // RemoveSetting
        configuration.subtitle = "2번째"
        //
        
        configuration.imagePadding = 10
        configuration.imagePlacement = .top
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = style.foregroundColor
        configuration.image = UIImage(systemName: "star")
        
        return configuration
    }
}
