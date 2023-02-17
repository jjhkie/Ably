//
//  UINavigationController+.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/19.
//

import UIKit

extension UINavigationController{
    func setCommonBar(_ title: String){
        self.navigationBar.topItem?.title = title
        //self.navigationBar.topItem?.title = title
        
        //let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        //backBarButtonItem.tintColor = .black
        //self.navigationBar.topItem?.backButtonTitle = ""
        //self.navigationBar.topItem?.backBarButtonItem = backBarButtonItem
        //self.navigationItem.backBarButtonItem = backBarButtonItem
        //leading Button
        let menuButton = self.makeSymbolButton(self,
                                               action: Selector("menuPush"),
                                               symbolName: "text.justify")
        self.navigationBar.topItem?.leftBarButtonItem = menuButton
        
        navigationBar.backgroundColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    @objc private func menuPush(){
        let vc = CollectionController()
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(vc, animated: true)
        //self.pushViewController(CollectionController(), animated: true)
    }
    
    @objc private func basketPush(){
        self.pushViewController(BasketController(), animated: true)
    }
    
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
    
    func trailingButton(_ text: String){
        let basketButton = self.makeSymbolButton(self,
                                                 action: Selector("basketPush"),
                                                 symbolName: "basket")
        
        let secondButton = self.makeSymbolButton(self,
                                                action: Selector("abc"),
                                                symbolName: text)
        
        self.navigationBar.topItem?.rightBarButtonItems = [basketButton,secondButton]
    }
    
}

