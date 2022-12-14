//
//  TabController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit


final class TabController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLayout()
        attribute()
    }
}

extension TabController{
    private func tabLayout(){
        let tabControllers: [UIViewController] = TabBarItem.allCases
            .map{
                let viewController = $0.controller
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: $0.icon.default,
                                                         selectedImage: $0.icon.selected)
                return viewController
            }
        
        self.viewControllers = tabControllers
    }
    
    private func attribute(){
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
        
    }
}


