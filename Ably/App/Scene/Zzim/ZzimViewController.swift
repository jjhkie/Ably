//
//  ZzimViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources
import RxCocoa
import Then



final class ZzimViewController: UIViewController{
    
    let bag = DisposeBag()
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: zzimLayout()).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        
        $0.register(ZzimRoundCell.self, forCellWithReuseIdentifier: "RoundCell")
        $0.register(ZzimBoxCell.self, forCellWithReuseIdentifier: "BoxCell")
        $0.register(ZzimHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bind(ZzimViewModel())
        attribute()
        layout()
    }
}

extension ZzimViewController{
    func bind(_ VM: ZzimViewModel){
        
        let dataSource = dataSource()
        
        let input = ZzimViewModel.Input()
        
        let output = VM.transform(input: input)
        
        output.cellData
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
    }
    
    private func attribute(){


            navigationController?.trailingButton("magnifyingglass")

    }
    
    private func layout(){
        [collectionView].forEach{
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

//TODO __ Utils 에 따로 분리
extension ZzimViewController{
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<ZzimModel>{
        return RxCollectionViewSectionedReloadDataSource<ZzimModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch dataSource[indexPath]{
                case .SignSectionItem(_):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCell", for: indexPath) as! ZzimRoundCell
                    //cell.backgroundColor = .blue
                    var content = cell.backgroundConfiguration
                    //content?.backgroundColor = .blue
                    cell.backgroundConfiguration = content
                    
                    return cell
                case let .BoxSectionItem(title, count):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxCell", for: indexPath) as! ZzimBoxCell
                    //dataSource.sectionModels
                  
                    cell.setData(title,count)
                    cell.backgroundColor = .blue
                    var content = cell.backgroundConfiguration
                    content?.backgroundColor = .blue
                    cell.backgroundConfiguration = content
                    return cell
                }
            }
            ,configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                switch kind{
                case UICollectionView.elementKindSectionHeader:
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! ZzimHeaderView
                    let headerText = dataSource.sectionModels[indexPath.section].title
                    header.setText(headerText)
                    
                    return header
                    
                default:
                    fatalError()
                }
                
            }
        )
    }
}


