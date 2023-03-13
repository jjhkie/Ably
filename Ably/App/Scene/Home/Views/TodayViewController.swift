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
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: todayLayout()).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(CellReusable.commonCollectionCell)
        $0.register(CellReusable.bannerCell)
        $0.register(ZzimHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
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
    
    
    private func attribute(){


        
        
    }
    
    private func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
       
        //collectionView
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        
        
    }
}

extension TodayViewController{
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<TodayModel>{
        return RxCollectionViewSectionedReloadDataSource<TodayModel>(
            configureCell:{ dataSource, collectionView, indexPath, item in
                switch dataSource[indexPath]{
                case .NewYearSaleItem(_):
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
                    cell.backgroundColor = .blue
                    return cell
                case .PagerViewItem(_):
                    let cell = collectionView.dequeue(CellReusable.bannerCell, for: indexPath)
                    cell.backgroundColor = .blue
                    return cell
                case .MenuViewItem(_,_):
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
                    cell.backgroundColor = .blue
                    return cell
                case .FirstOrderBenefitsItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName):
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
                    cell.backgroundColor = .blue
                    
                    return cell
                case .RecommendProductItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName):
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
                    cell.backgroundColor = .blue
                    return cell
                case .HotTenItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName, totalSale: let totalSale):
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
                    cell.backgroundColor = .blue
                    return cell
                case .SyagRecommendProductItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName):
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
                    cell.backgroundColor = .blue
                    return cell
                case .PlusItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName, totalSale: let totalSale):
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
                    cell.backgroundColor = .blue
                    return cell
                }
            }
            ,configureSupplementaryView: {(dataSource, collectionView,kind, IndexPath) -> UICollectionReusableView in
                
                switch kind{
                case UICollectionView.elementKindSectionHeader:
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: IndexPath) as! ZzimHeaderView
                    
                    let headerText = dataSource.sectionModels[IndexPath.section].title
                    print(headerText)
                    header.setText(headerText)
                    return header
                    
                default:
                    print("aaa")
                    fatalError()
                }
            }
        )
    }
}




