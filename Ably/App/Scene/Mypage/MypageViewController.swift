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
        $0.register(CellReusable.myPageHeader)
        $0.register(CellReusable.myPageCell)
        
    }
    
}

extension MypageViewController{
    func bind(_ VM: MyPageViewModel){
        
        let input = MyPageViewModel.Input()
        
        let output = VM.transform(input: input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MyPageData>(
            configureCell: { dataSource, tableView, indexPath, item in
                
                if(indexPath.row == 0){
                    guard let line = tableView.dequeue(CellReusable.myPageHeader) else {return UITableViewCell()}
                    line.selectionStyle = .none
                    
                    return line
                }else{

                    guard let cell = tableView.dequeue(CellReusable.myPageCell) else { return UITableViewCell()}
                    cell.selectionStyle = .gray
                    cell.setData(MyPageEnum.allCases[indexPath.row])
                    return cell
                }
   
            }
        )
        
        output.tableCellData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: bag)
        
        tableView.rx.itemSelected
            .bind(onNext: {
                self.show(MyPageEnum.allCases[$0.row].showController!, sender: true)
                print(MyPageEnum.allCases[$0.row])
            })
            .disposed(by: bag)

            
        
    }
    
    private func attribute(){
        //NavigationBar
        self.navigationController?.setcommonBar("")
        self.title = "마이페이지"
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

