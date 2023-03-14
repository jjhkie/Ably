//
//  TodayViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/05.
//

import UIKit
import SnapKit
import XLPagerTabStrip
import Then
import RxSwift
import RxCocoa
import RxDataSources


extension TodayViewController:IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "투데이")
    }
}

final class TodayViewController: UIViewController{
    
    let bag = DisposeBag()
    
    var parentViewModel: MainViewModel? = nil
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: todayLayout()).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(CellReusable.commonCollectionCell)
        $0.register(CellReusable.bannerCell)
        $0.register(CellReusable.productCell)
        $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(TodayViewModel())
        attribute()
        layout()
    }
}


extension TodayViewController{
    
    func bind(_ VM: TodayViewModel){
        let dataSource = dataSource()
        
        //Input
        let input = TodayViewModel.Input(scrollEvent: collectionView.rx.didScroll.map{self.collectionView.contentOffset.y}.asObservable())
        
        //Output
        let output = VM.transform(input: input)
        
        //스크롤차이에 따른 mainViewModel의 값 변경 코드
        output.differenceValue
            .asObservable()
            .subscribe(onNext: {
                self.parentViewModel?.menuTapHidden($0)
            })
            .disposed(by: bag)
        
        //Item Click Event
        collectionView.rx.itemSelected
            .bind{
                if $0.section > 2{
                    let vc = DetailController()
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            .disposed(by: bag)
        
        output.cellData
            .drive(collectionView.rx.items(dataSource:dataSource))
            .disposed(by: bag)
        
    }
}

extension TodayViewController: ViewLayout{
    
    
    
    func attribute(){
    }
    
    func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
        
        //collectionView
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}






