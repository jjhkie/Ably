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
    
    
    var scrollDifference: Double = 0.0
    var contentHeight = 50

    override func viewDidLoad() {
        self.tabBarCustom()

        super.viewDidLoad()
        view.backgroundColor = .white
        
        attribute()
        layout()
    }
    //TabStrip 함수 적용 TODO REMOVE
    override func pageOffsetForChild(at index: Int) -> CGFloat {
        print("ing")
        return CGFloat(index) * containerView.bounds.width
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        print("hey")
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let todayCo = TodayViewController(nibName: nil  , bundle:nil)
        todayCo.delegate = self
        return [todayCo, ShoppingMallViewController(),BrandController(),BeautyController(),PhoneCaseController(),CodiController(),BestController(),HotDealController()]
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        super.scrollViewDidEndScrollingAnimation(scrollView)
        print("abc")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        print(indexPath)
    }
    override var scrollPercentage: CGFloat{
        containerView.contentOffset.y = 0.0
        print("ad")
        return super.scrollPercentage
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        super.scrollViewWillBeginDragging(scrollView)
        print("dragging")
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

extension Reactive where Base: UICollectionView{
    var delegate : DelegateProxy<UICollectionView, UICollectionViewDelegate>{
        return RxCollectionViewDelegateProxy.proxy(for: self.base)
    }
    
    
   
}
