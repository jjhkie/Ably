//
//  MainViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit
import Tabman
import Pageboy



final class MainViewController: TabmanViewController{
    
    ///TopTabBar
    let topTabView = UIView()
    private var viewController = [TodayViewController(), ShoppingMallViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController(),UIViewController()]
    
    ///SearchBar & MenuButton
    let topStackView = UIStackView()
    let menuBt = UIButton()
    let alertBt = UIButton()
    let basketBt = UIButton()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.dataSource = self
        

        //
        attribute()
        layout()
    }
    
}

extension MainViewController{
    
    func bind(){
        
    }
    
    private func attribute(){
        self.navigationController?.isNavigationBarHidden = true
        //TopTabBar Attribute()
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.buttons.customize{//Item 선택에 따른 color 설정
            $0.tintColor = .gray
            $0.selectedTintColor = .black
        }
        bar.layout.contentInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        //indicator Attribute()
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .custom(view: topTabView, layout: nil))
        
        //TopStackView
        topStackView.axis = .horizontal
        topStackView.layoutMargins = UIEdgeInsets(top: .zero, left: 5, bottom: .zero, right: 5)//StackView Margin Setting
        topStackView.isLayoutMarginsRelativeArrangement = true//StackView Margin Setting
        
        //Top Button Settings
        [menuBt,alertBt,basketBt].enumerated().forEach{
            $1.setImage(UIImage(systemName: TopButtonItem(rawValue: $0)!.imageTitle), for: .normal)
            $1.imageView?.tintColor = .black
            
        }
    }
    
    private func layout(){
        ///MainView에 추가
        [menuBt,searchController.searchBar,alertBt,basketBt].forEach{
            topStackView.addArrangedSubview($0)
        }
        
        ///StackView에 추가
        [topStackView,topTabView].forEach{
            view.addSubview($0)
        }
        
        /// Settings
        topStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        topTabView.snp.makeConstraints{
            $0.top.equalTo(topStackView.snp.bottom)
            $0.trailing.leading.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//TopBar
extension MainViewController: PageboyViewControllerDataSource, TMBarDataSource{
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewController.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewController[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        
        switch index{
        case 0:
            return TMBarItem(title: "투데이")
        case 1:
            return TMBarItem(title: "쇼핑몰")
        case 2:
            return TMBarItem(title: "샥-출발")
        case 3:
            return TMBarItem(title: "브랜드")
        case 4:
            return TMBarItem(title: "뷰티")
        case 5:
            return TMBarItem(title: "폰케이스")
        case 6:
            return TMBarItem(title: "코디")
        case 7:
            return TMBarItem(title: "베스트")
        case 8:
            return TMBarItem(title: "핫딜")
        default:
            return TMBarItem(title: "page")
        }
    }
}

