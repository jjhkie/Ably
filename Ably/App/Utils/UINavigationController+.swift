//
//  UINavigationController+.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/19.
//

import UIKit

extension UINavigationController{
    func setcommonBar(_ title: String){
        navigationBar.backgroundColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationBar.topItem?.title = title
    }
}
