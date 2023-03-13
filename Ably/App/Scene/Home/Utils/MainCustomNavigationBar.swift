//
//  MainCustomNavigationBar.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/12.
//

import UIKit

class MainCustomNavigationBar: UINavigationBar{
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = 300
        backgroundColor = .red
        return newSize
    }
}

extension UINavigationBar{
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = 300
        backgroundColor = .red
        return newSize
    }
}
