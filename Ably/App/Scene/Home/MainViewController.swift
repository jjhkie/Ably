//
//  MainViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit
import XLPagerTabStrip



final class MainViewController: ButtonBarPagerTabStripViewController {
    ///TopTabBar
    let topTabView = UIView()
    
    ///SearchBar & MenuButton
    let topStackView = UIStackView()
    var config = UIButton.Configuration.plain()
    
    let menuBt = UIButton()
    let alertBt = UIButton()
    let basketBt = UIButton()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureButtonBar()
        //
        attribute()
        layout()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [TodayViewController(), ShoppingMallViewController()]
    }
    
}



extension MainViewController{
    
    func bind(){
        
    }
    
    private func attribute(){
        //self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = "title"
        

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
            settings.style.buttonBarBackgroundColor = .white
            settings.style.buttonBarItemBackgroundColor = .white

            settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 17.0)!
            settings.style.buttonBarItemTitleColor = .gray
            
            settings.style.buttonBarMinimumLineSpacing = 0
            settings.style.buttonBarItemsShouldFillAvailableWidth = true
            settings.style.buttonBarLeftContentInset = 0
            settings.style.buttonBarRightContentInset = 0

            settings.style.selectedBarHeight = 3.0
            settings.style.selectedBarBackgroundColor = .purple
            
            // Changing item text color on swipe
            changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
                guard changeCurrentIndex == true else { return }
                oldCell?.label.textColor = .gray
                newCell?.label.textColor = .purple
            }
        }
    
    private func layout(){
        
        
        ///StackView에 추가
        [menuBt,searchController.searchBar,alertBt,basketBt].forEach{
            topStackView.addArrangedSubview($0)
        }
        
        ///MainView에 추가
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
            //$0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}


