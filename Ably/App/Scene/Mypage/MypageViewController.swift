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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind(MyPageViewModel())
        attribute()
        layout()
    }
    
    private let bag = DisposeBag()
    
    private let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(MyPageCell.self, forCellReuseIdentifier: "Line")
        $0.register(TableHeader.self, forCellReuseIdentifier: "FirstLine")
        //$0.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
        
    }
    
}

extension MypageViewController{
    func bind(_ VM: MyPageViewModel){
        
        let input = MyPageViewModel.Input()
        
        let output = VM.transform(input: input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MyPageData>(
            configureCell: { dataSource, tableView, indexPath, item in
                
                if(indexPath.row == 0){
                    let line = tableView.dequeueReusableCell(withIdentifier: "FirstLine", for: indexPath) as! TableHeader
                    
                    return line
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Line", for: indexPath) as! MyPageCell
                    cell.setData(indexPath.row, item)
                    return cell
                }
   
            }
        )
        
//        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
//              configureCell: { ds, tv, _, item in
//                  let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
//                  cell.textLabel?.text = "Item \(item)"
//
//                  return cell
//              },
//              titleForHeaderInSection: { ds, index in
//                  return ds.sectionModels[index].header
//              }
//          )

//        output.tableCellData
//            .drive(tableView.rx.items(cellIdentifier: "Line",cellType: MyPageCell.self)){ row,data,cell in
//                if(row == 0){
//                    self.tableView.rowHeight = 100
//                }else{
//                    self.tableView.rowHeight = 60
//                }
//                cell.setData(row,data)
//            }
//            .disposed(by:bag)
        output.tableCellData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
    }
    
    private func attribute(){
        //NavigationBar
        self.navigationController?.navigationBar.topItem?.title = "마이페이지"
        self.navigationController?.setcommonBar()
        self.navigationItem.leadingButton()
        
        self.navigationItem.trailingButton("bell")
    }
    
    
    private func layout(){
        view.addSubview(tableView)
        
        //tableView Layout
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

