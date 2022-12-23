//
//  UINavigationItem.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/19.
//

import Foundation
import UIKit

extension UINavigationItem{
    //버튼 만들기
    func makeSymbolButton(_ target: Any?, action: Selector, symbolName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: symbolName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .black
            
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
            
        return barButtonItem
    }
    
    func leadingButton(){
        let menuButton = self.makeSymbolButton(self,
                                               action: Selector("pushToWrite"),
                                               symbolName: "text.justify")
        self.leftBarButtonItem = menuButton
    }
}
