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

                    if view.topViewController is MainViewController{
                        view.navigationBar.topItem?.title = "test"
                    }else if view.topViewController is MarketViewController{
                        
                        view.navigationBar.topItem?.title = TabBarItem.market.title
                    }else if view.topViewController is SyagController{
                        view.navigationBar.topItem?.title = TabBarItem.syag.title
                    }
                }
            })
            .disposed(by: bag)
        

    }
    @objc func leadingButtonAction() {
        // Leading Button Action 실행
        print("Leading Button Tapped")
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


