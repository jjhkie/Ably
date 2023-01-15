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
    
    private let menuBar = UIStackView()
    private let rankingBar = UIStackView()

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
        return [TodayViewController(), ShoppingMallViewController(),BrandController(),BeautyController(),PhoneCaseController(),CodiController(),BestController(),HotDealController()]
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        super.scrollViewDidEndScrollingAnimation(scrollView)
        print("abc")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        collectionView.delegate = self
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        buttonBarView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(20)
        }
    }
}


extension MainViewController: ChangeTopTab{
    func changTab() {
        print("dddddd")
    }
    
    
}

