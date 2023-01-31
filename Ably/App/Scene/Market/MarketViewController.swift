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
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.register(CellReusable.marketCell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
            .drive(tableView.rx.items){tableView,index,data in
                let cell = self.tableView.dequeue(CellReusable.marketCell)
                cell?.setData(data, index)
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
        self.segmentControl.backgroundColor = .white
        
    
    }
    
    func layout(){
        [segmentControl,tableView].forEach{
            view.addSubview($0)
        }
        segmentControl.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

