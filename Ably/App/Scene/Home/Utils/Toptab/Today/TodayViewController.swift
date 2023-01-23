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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        bind()
        attribute()
        layout()
    }
}

func getLayout() -> UICollectionViewCompositionalLayout {
    
    UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
        switch section {
        case 0:
            let itemFractionalWidthFraction = 1.0
            let groupFractionalHeightFraction = 1.0 / 4.0
            let itemInset: CGFloat = 2.5
            
            // Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: 0, bottom: itemInset, trailing: 0)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(groupFractionalHeightFraction)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            return section
        case 1:
            
            let itemInset: CGFloat = 2.5
            
            // Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0 / 2.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / 6.0),
                heightDimension: .fractionalHeight(1.0 / 4.0)
            )
            
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            return section
        case 2:
            
            let itemInset: CGFloat = 2.5
            
            // Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / 3.0),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0 / 3.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            return section
        default:
            let itemFractionalWidthFraction = 1.0 / 5.0 // horizontal 5개의 셀
            let groupFractionalHeightFraction = 1.0 / 4.0 // vertical 4개의 셀
            let itemInset: CGFloat = 2.5
            
            // Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(groupFractionalHeightFraction)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            return section
        }
    }
}

extension TodayViewController{
    
    func bind(){
        
        
        collectionView.rx.todayScrollDid.asObservable()
            .bind(onNext: {_ in
                print("rxDouble")
            })
            .disposed(by: bag)
            
            
        }
    
    private func attribute(){
        //CollectionView
        
    }
    
    private func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
        
        //collectionView
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
            //$0.trailing.leading.equalToSuperview()
            //$0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

//collectionView DataSource
extension TodayViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .black
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
}

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
//
//extension TodayViewController{
//    func todayDataSource() ->
//    RxCollectionViewSectionedReloadDataSource<TodayModel>{
//        return RxCollectionViewSectionedReloadDataSource<TodayModel>(
//            configureCell: {dataSource, collectionView, indexPath, item in
//                switch dataSource[indexPath]{
//                case .NewYearSaleItem(image: let image):
//                    <#code#>
//                case .PagerViewItem(image: let image):
//                    <#code#>
//                case .MenuViewItem(image: let image, title: let title):
//                    <#code#>
//                case .FirstOrderBenefitsItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName):
//                    <#code#>
//                case .RecommendProductItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName):
//                    <#code#>
//                case .HotTenItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName, totalSale: let totalSale):
//                    <#code#>
//                case .SyagRecommendProductItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName):
//                    <#code#>
//                case .PlusItem(sale: let sale, price: let price, syagCheck: let syagCheck, marketName: let marketName, ProductName: let ProductName, totalSale: let totalSale):
//                    <#code#>
//
//                }
//
//            })
//    }
//}
