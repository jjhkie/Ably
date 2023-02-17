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

final class DetailController: UIViewController{
    
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
        $0.register(CellReusable.MarketInfoCell)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind(DetailViewModel())
        attribute()
        layout()
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
        self.title = "상품정보"
        
        navigationController?.isNavigationBarHidden = false
    }
    
    private func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }


        collectionView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension DetailController{
    func dataSource() ->
    RxCollectionViewSectionedReloadDataSource<DetailModel>{
        return RxCollectionViewSectionedReloadDataSource<DetailModel>(configureCell: {
            dataSource, collectionView, indexPath, item in
            switch dataSource[indexPath]{
            case .ProductImageItem(_):
                
                let cell = collectionView.dequeue(CellReusable.commonCollectionCell,for: indexPath)
                var content = cell.defaultBackgroundConfiguration()
                
                
                cell.backgroundColor = .blue
                return cell
            case let .MarketInfoItem(logo: logo, marketName: marketName, marketStyle: marketStyle, marketFavorites: marketFavorites):
                let cell = collectionView.dequeue(CellReusable.MarketInfoCell, for: indexPath) as! MarketInfoCell
                
                cell.setData(marketName,marketStyle)
                
                
                
                return cell
            }
        })
    }
}
