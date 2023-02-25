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
        case image(title: String)
        case favorite
        
        var foregroundColor: UIColor?{
            switch self{
            case .basic:
                return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            case .image(title: _):
                return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            case .favorite:
                return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            }
            
        }
        
        var title: String?{
            switch self{
                
            case .basic:
                return nil
            case .image(title: _):
                return nil
            case .favorite:
                return "2번쨰"
            }
        }
        
        var mainImage: UIImage?{
            switch self{
            case .basic:
                return nil
            case .image(title: let title):
                return UIImage(systemName: title)
            case .favorite:
                return UIImage(systemName: "star")
            }
        }
    }
        
    static func buttonStyle(style: ButtonStyle) -> UIButton.Configuration{
        var configuration = UIButton.Configuration.plain()
        
        //TODO // RemoveSetting
        configuration.subtitle = style.title
        
        configuration.imagePadding = 10
        configuration.imagePlacement = .top
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = style.foregroundColor
        configuration.image = style.mainImage
        
        return configuration
    }
}

