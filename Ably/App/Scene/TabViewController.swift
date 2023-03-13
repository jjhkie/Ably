//
//  TabController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import RxSwift


final class TabViewController: UITabBarController{
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabLayout()
        bind()
        attribute()
    }
}

extension TabViewController{

    //function
    func bind(){
        //Tabbar 클릭했을 때 실행되는 코드
        rx.didSelect
            .subscribe(onNext: {viewController in
                if let view = viewController as? UINavigationController{
                    if view.topViewController is HomeViewController{
                        
                    }else if view.topViewController is MarketViewController{
                        view.navigationBar.topItem?.title = TabBarItem.market.title
                    }else if view.topViewController is SyagController{
                        view.navigationBar.topItem?.title = TabBarItem.syag.title
                    }
                }
            })
            .disposed(by: bag)
    }
    
    //design
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

        
        //navigationBar 설정
        for viewController in tabControllers{
            if let navigationController = viewController as? UINavigationController{
                //NavigaionBar leading Button
                navigationController.setCommonBar()
            }
        }
    }
}


