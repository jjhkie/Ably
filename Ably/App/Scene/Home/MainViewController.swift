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
import RxSwift
import RxCocoa

final class MainViewController: ButtonBarPagerTabStripViewController {
    
    private let menuBar = UIStackView()
    private let rankingBar = UIStackView()
    private let bag = DisposeBag()
    
    
    var scrollDifference: Double = 0.0
    var contentHeight = 50

    override func viewDidLoad() {
        self.tabBarCustom()

        super.viewDidLoad()
        view.backgroundColor = .white
        
        attribute()
        layout()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let todayCo = TodayViewController(nibName: nil  , bundle:nil)

        return [todayCo, ShoppingMallViewController(),BrandController(),BeautyController(),PhoneCaseController(),CodiController(),BestController(),HotDealController()]
    }
}

extension MainViewController{

    func bind(){
        
    }
    
    private func attribute(){
        navigationController?.isNavigationBarHidden = true
       
     
        //remove
        menuBar.backgroundColor = .blue
        rankingBar.backgroundColor = .red
        
      
        

    }
    
    private func layout(){
        
        //TabBar Container Auto Layout
        self.containerLayout()
        
        
        [menuBar,rankingBar].forEach{
            view.addSubview($0)
        }
        
        menuBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        rankingBar.snp.makeConstraints{
            $0.top.equalTo(menuBar.snp.top).offset(contentHeight)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        buttonBarView.snp.makeConstraints{
            $0.top.equalTo(rankingBar.snp.top).offset(contentHeight)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(20)
        }
        self.view.bringSubviewToFront(buttonBarView)
    }
}

extension MainViewController: ChangeTopBarDelegate{
    
    func changeTopSetting(_ scrollValue: Double) {
        if(scrollValue > scrollDifference && scrollValue - scrollDifference > 10){
            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut, animations: {
                self.rankingBar.snp.updateConstraints{
                    $0.top.equalTo(self.menuBar.snp.top).offset(0)
                }
                self.rankingBar.superview?.layoutIfNeeded()
                self.buttonBarView.snp.updateConstraints{
                    $0.top.equalTo(self.rankingBar.snp.top).offset(0)
                }
                self.buttonBarView.superview?.layoutIfNeeded()
            })
        }else if (scrollValue < scrollDifference && scrollDifference - scrollValue > 10){
            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut, animations: { [self] in
                self.rankingBar.snp.updateConstraints{
                    $0.top.equalTo(self.menuBar.snp.top).offset(contentHeight)
                }
                self.rankingBar.superview?.layoutIfNeeded()
                self.buttonBarView.snp.updateConstraints{
                    $0.top.equalTo(self.rankingBar.snp.top).offset(contentHeight)
                }
                self.buttonBarView.superview?.layoutIfNeeded()
            })
        }
        scrollDifference = scrollValue
        print("aaa")
    }
}


