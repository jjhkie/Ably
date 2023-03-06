//
//  DetailController.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/14.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources
import RxCocoa
import Then
import XLPagerTabStrip

final class DetailController: ButtonBarPagerTabStripViewController{

    let imageArrays = ["1.jpg","2.jpg","3.jpg"]
    
    let bag = DisposeBag()

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: detailLayout()).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(CellReusable.commonCollectionCell)
        $0.register(CellReusable.ProductInfoCell)
        $0.register(CellReusable.DeliveryInfoCell)
        $0.register(CellReusable.ProductDetailInfoCell)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
   


    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        bind(DetailViewModel())
        attribute()
        layout()
        containerView.backgroundColor = .black
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ProductInfo(),ProductReview()]
    }
}


extension DetailController{
    
    func bind(_ VM: DetailViewModel){
        let dataSource = dataSource()
        
        let input = DetailViewModel.Input()
        
        let output = VM.transform(input: input)
        
        output.cellData
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func attribute(){
        collectionView.contentInsetAdjustmentBehavior = .never
        self.title = "상품정보"

        navigationController?.isNavigationBarHidden = false
    }
    
    private func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
        collectionView.addSubview(buttonBarView)
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
//        containerView.snp.makeConstraints{
//            $0.top.equalTo(collectionView.snp.bottom)
//            $0.trailing.leading.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaInsets)
//        }
//        testView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }


        
    }
}

extension DetailController{
    func dataSource() ->
    RxCollectionViewSectionedReloadDataSource<DetailModel>{
        return RxCollectionViewSectionedReloadDataSource<DetailModel>(configureCell: {
            dataSource, collectionView, indexPath, _ in
            switch dataSource[indexPath]{
            case let .ProductImageItem(image, marketName, marketStyle, marketFavorites, productName, price, sale):
                
                let cell = collectionView.dequeue(CellReusable.ProductInfoCell, for: indexPath)
                
                cell.setData(count: price, sale: sale)
                cell.setText(marketImage: image,marketName: marketName, marketStyle: marketStyle, marketFavorites: marketFavorites, productName: productName)
                
                cell.backgroundColor = .blue

                return cell
                
            case .DeliveryInfoItem(syag: let syag):
                let cell = collectionView.dequeue(CellReusable.DeliveryInfoCell, for: indexPath)
                
                return cell
            case .ProductInfoItem(text: let text):
                let cell = collectionView.dequeue(CellReusable.ProductDetailInfoCell, for: indexPath)
                cell.addSubview(self.buttonBarView)
                cell.addSubview(self.containerView)
                //cell.backgroundColor = .blue
                return cell
            }
        })
    }
}
