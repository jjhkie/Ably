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

protocol ChangeTopBarDelegate: AnyObject{
    func changeTopSetting(_ scrollValue: Double )
}

final class TodayViewController: UIViewController,IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "투데이")
    }
    
    var bag = DisposeBag()
    
    weak var delegate: ChangeTopBarDelegate?
    
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: todayLayout()).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(CellReusable.commonCollectionCell)
        $0.register(ZzimHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.dataSource = self
        bind(TodayViewModel())
        attribute()
        layout()
    }
}


extension TodayViewController{
    
    func bind(_ VM: TodayViewModel){
        let dataSource = dataSource()
        let input = TodayViewModel.Input()
        
        let output = VM.transform(input: input)
        
        
        //scroll Event
        collectionView.rx.todayScrollDid.asObservable()
            .bind{
                print($0)
                print("rxDouble")
            }
            .disposed(by: bag)
        
        //Item Click Event
        collectionView.rx.itemSelected
            .bind{
                if $0.section > 2{
               
                    self.navigationController?.pushViewController(DetailController(), animated: true)
                }
                    
            }
            .disposed(by: bag)
        
        output.cellData
            .drive(collectionView.rx.items(dataSource:dataSource))
            .disposed(by: bag)
        
        }
    
    
    private func attribute(){
        //CollectionView
        self.title = "aa"
    }
    
    private func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
        
        //collectionView
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
                    let cell = collectionView.dequeue(CellReusable.commonCollectionCell, for: indexPath)
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

////collectionView DataSource
//extension TodayViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        20
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//        
//        cell.backgroundColor = .black
//        return cell
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        4
//    }
//}

extension Reactive where Base: UICollectionView{
    var rxDelegate : DelegateProxy<UICollectionView, UICollectionViewDelegate>{
        return RxCollectionViewDelegateProxy.proxy(for: self.base)
    }
    
    
    var todayScrollDid: Observable<Double>{
        return rxDelegate.methodInvoked(#selector(UICollectionViewDelegate.scrollViewDidScroll(_:)))
            .map{
                return $0 as? Double ?? 0.0
            }
    }
}
