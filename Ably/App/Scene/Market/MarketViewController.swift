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
    
    private let segmentControl = UISegmentedControl().then{
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
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

        
        //segmentControl
        
        self.segmentControl.insertSegment(withTitle: "랭킹", at: 0, animated: true)
        self.segmentControl.insertSegment(withTitle: "즐겨찾기", at: 1, animated: false)
        self.segmentControl.selectedSegmentIndex = 0
    
    }
    
    func layout(){
        [segmentControl,tableView].forEach{
            view.addSubview($0)
        }
        segmentControl.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

