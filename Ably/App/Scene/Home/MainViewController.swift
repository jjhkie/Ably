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
import FSPagerView

final class MainViewController: ButtonBarPagerTabStripViewController {
    
    private let menuBar = UIStackView().then{
        $0.axis = .horizontal
    }
    
    private let menuButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title: "text.justify"))
    }
    
    private let searchController = UISearchBar().then{
        $0.placeholder = "밸런타인 준비했나요?"
    }
    
    private let alertButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title: "bell"))
    }
    
    private let basketButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title:"basket"))
    }
    
    
    private let rankingBar = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let popularLabel = UILabel().then{
        $0.text = "인기"
        
        $0.layer.cornerRadius = 10
    }
    private let rankingLabel = UILabel().then{
        $0.text = " 1 룩북"
    }
    private let totalRanking = UILabel().then{
        $0.text = "전체랭킹 >"
    }
    private let bag = DisposeBag()
    
    ///FSPagerVIew
    private let pagerView = FSPagerView().then{
        $0.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        $0.itemSize = FSPagerView.automaticSize
    }
    
    private let pageControl = FSPageControl().then{
        $0.numberOfPages = 7
        $0.contentHorizontalAlignment = .right
        $0.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        //$0.contentInset
    }
    
    
    var scrollDifference: Double = 0.0
    var contentHeight = 50

    override func viewDidLoad() {
        self.tabBarCustom()

        super.viewDidLoad()
        
        view.backgroundColor = .white
        bind()
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
        //menuButton 클릭 시 화면 이동
        menuButton.rx.tap
            .bind{
                //self.navigationController?.show(CollectionController(), sender: nil)
                let vc = CollectionController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: bag)
    }
    
    private func attribute(){
        navigationController?.isNavigationBarHidden = true
        rankingBar.layoutMargins = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        rankingBar.isLayoutMarginsRelativeArrangement = true
        popularLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalRanking.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rankingLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        popularLabel.backgroundColor = .black
        popularLabel.textColor = .white

    }
    
    private func layout(){
        
        //TabBar Container Auto Layout
        self.containerLayout()
        
        [menuButton,searchController,alertButton,basketButton].forEach{
            menuBar.addArrangedSubview($0)
        }
        
        [popularLabel,rankingLabel,totalRanking].forEach{
            rankingBar.addArrangedSubview($0)
        }
        
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


