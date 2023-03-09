//
//  TabController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import RxSwift


final class TabController: UITabBarController{
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLayout()
        bind()
        attribute()
    }
    

}

extension TabController{

    func bind(){
        rx.didSelect
            .subscribe(onNext: {viewController in
                if let view = viewController as? UINavigationController{
                    if let mainView = view.topViewController as? MainViewController{
                        print("main")
                    }else if let marketView = view.topViewController as? MarketViewController{
                        
                    }
                }
            })
            .disposed(by: bag)
    }
    
    private func attribute(){
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
        
    }
    
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
}


