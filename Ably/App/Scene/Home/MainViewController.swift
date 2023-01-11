//
//  MainViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit
import XLPagerTabStrip
import Then



final class MainViewController: ButtonBarPagerTabStripViewController {

    
    ///SearchBar & MenuButton
    let topStackView = UIStackView()
    var config = UIButton.Configuration.plain()
    
    let menuBt = UIButton()
    let alertBt = UIButton()
    let basketBt = UIButton()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        configureButtonBar()
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        attribute()
        layout()
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [TodayViewController(), ShoppingMallViewController(),BrandController(),BeautyController(),PhoneCaseController(),CodiController(),BestController(),HotDealController()]
    }
    
    
}

extension MainViewController{
    
    func bind(){
        
    }
    
    private func attribute(){
        //self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.setcommonBar("title")
        self.navigationController?.hidesBarsOnSwipe = true

        //TopStackView
        topStackView.axis = .horizontal
        topStackView.backgroundColor = .white
        topStackView.layoutMargins = UIEdgeInsets(top: .zero, left: 5, bottom: .zero, right: 5)//StackView Margin Setting
        topStackView.isLayoutMarginsRelativeArrangement = true//StackView Margin Setting
        
        //Top Button Settings
        config.baseForegroundColor = .black
        [menuBt,alertBt,basketBt].enumerated().forEach{
            $1.setImage(UIImage(systemName: TopButtonItem(rawValue: $0)!.imageTitle), for: .normal)
            $1.configuration = config
        }
    }
    //XLPagerTabStrip Setting
    func configureButtonBar() {
        
        
        self.tabBarCustom()

        }
    
    private func layout(){
        
        //TabBar Container Auto Layout
        self.containerLayout()
        
        buttonBarView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(40)
        }
    }
}


