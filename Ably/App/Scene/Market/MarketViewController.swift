//
//  MarketViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import Then
import RxSwift
import SnapKit

final class MarketViewController: UIViewController{
    
    let bag = DisposeBag()
    
    private let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(CellReusable.marketCell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(MarketViewModel())
        attribute()
        layout()
    }
}


extension MarketViewController{
    func bind(_ VM: MarketViewModel){
        
        let input = MarketViewModel.Input()
        
        let output = VM.transform(input: input)
        
        output.tableCellData
            .drive(tableView.rx.items){b,a,index in
                let cell = self.tableView.dequeue(CellReusable.marketCell)
                
                return cell!
            }
            .disposed(by: bag)
        
        
    }
    
    func attribute(){
        //NavigationBar
        navigationController?.setcommonBar()
        self.title = "마켓"
        self.navigationItem.leadingButton()
        self.navigationItem.trailingButton("magnifyingglass")

    }
    
    func layout(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
