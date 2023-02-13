//
//  MypageViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit
import RxSwift
import Then
import RxDataSources

final class MypageViewController: UIViewController{
    
    private let bag = DisposeBag()
    
    private let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(CellReusable.myPageHeader)
        $0.register(CellReusable.myPageCell)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind(MyPageViewModel())
        attribute()
        layout()
    }
    

    
}

extension MypageViewController{
    func bind(_ VM: MyPageViewModel){
        
        let input = MyPageViewModel.Input()
        
        let output = VM.transform(input: input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MyPageData>(
            configureCell: { dataSource, tableView, indexPath, item in
                if(indexPath.section == 0){
                    if(indexPath.row == 0){
                        guard let line = tableView.dequeue(CellReusable.myPageHeader) else {return UITableViewCell()}
                        line.selectionStyle = .none
                        return line
                    }else{
                        guard let cell = tableView.dequeue(CellReusable.myPageCell) else { return UITableViewCell()}
                        cell.selectionStyle = .gray
                        cell.setData(dataSource.sectionModels[indexPath.section].items[indexPath.row])
                        return cell
                    }
                }else{
                    guard let cell = tableView.dequeue(CellReusable.myPageCell) else { return UITableViewCell()}
                    cell.selectionStyle = .gray
                    cell.setData(dataSource.sectionModels[indexPath.section].items[indexPath.row])
                    return cell
                }
            }
        )
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return MyPageEnum.allCases[index].description
                
        }
        
        
        
        output.tableCellData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: bag)
        
        tableView.rx.itemSelected
            .bind(onNext: {
                self.show(MyPageEnum.allCases[$0.section].showController[$0.row]!, sender: true)
            })
            .disposed(by: bag)

            
        
    }
    
    private func attribute(){
        //NavigationBar
        navigationController?.setCommonBar("마이페이지")
      
        navigationController?.trailingButton("bell")
        
        
    }
    
    
    private func layout(){
        view.addSubview(tableView)
        
        //tableView Layout
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

