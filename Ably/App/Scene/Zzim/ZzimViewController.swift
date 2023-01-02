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


final class ZzimViewController: UIViewController{
    
    let bag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: zzimLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        
        view.register(ZzimRoundCell.self, forCellWithReuseIdentifier: "RoundCell")
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.register(ZzimHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
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
        //네비게이션 바 설정
        self.navigationController?.setcommonBar()
        self.navigationController?.navigationBar.topItem?.title = "찜"
        
        self.navigationController?.navigationItem.leadingButton()

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

/// TODO __ Utils 에 따로 분리
func zzimLayout() -> UICollectionViewCompositionalLayout{
    UICollectionViewCompositionalLayout{ (section, env) -> NSCollectionLayoutSection? in
        switch section{
        case 0:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5 )
            
            
            return section
            
        case 1:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5 )
            
            
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


//TODO __ Utils 에 따로 분리
extension ZzimViewController{
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<ZzimModel>{
        return RxCollectionViewSectionedReloadDataSource<ZzimModel>(
            configureCell: { dataSource, collectionView, indexPath, item in
                if(indexPath.section == 0){
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCell", for: indexPath) as! ZzimRoundCell
                    //cell.backgroundColor = .blue
                    var content = cell.backgroundConfiguration
                    //content?.backgroundColor = .blue
                    cell.backgroundConfiguration = content
                    
                    return cell
                    
                }else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
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
                    var headerText = dataSource.sectionModels[indexPath.section].header
                    header.setText(headerText)
                    
                    return header
                    
                default:
                    fatalError()
                }
                
            }
        )
    }
}


