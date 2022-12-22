//
//  MypageViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit
import RxSwift

final class MypageViewController: UIViewController{

    let tableView = UITableView()
    
    let bag = DisposeBag()
    
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
        
        
        output.tableCellData
            .drive(tableView.rx.items(cellIdentifier: "Cell",cellType: MyPageCell.self)){ row,data,cell in
                
                cell.setData(row,data)
            }
            .disposed(by:bag)
        
        tableView.backgroundColor = .white
        tableView.delegate = self
    }
    
    func attribute(){
        //NavigationBar
        self.navigationController?.navigationBar.topItem?.title = "마이페이지"
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .black
        let menuButton = self.navigationItem.makeSymbolButton(self,
                                                                     action: Selector("pushToWrite"),
                                                                     symbolName: "text.justify")
        self.navigationItem.leftBarButtonItem = menuButton
        
        let alertButton = self.navigationItem.makeSymbolButton(self,
                                                               action: Selector("abc"),
                                                               symbolName: "bell")
        
        let basketButton = self.navigationItem.makeSymbolButton(self,
                                                               action: Selector("abc"),
                                                               symbolName: "basket")
        
        self.navigationItem.rightBarButtonItems = [basketButton,alertButton]
        
        //tableView
        tableView.separatorStyle = .none // 밑줄 제거 
        tableView.register(MyPageCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
    }
    
    
    func layout(){
        [tableView].forEach{
            view.addSubview($0)
        }
        
        //tableView Layout
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MypageViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(indexPath.row == 0){
//            return 100
//        }
//        return 60
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? TableHeader else{ return UIView()}
        
        return view
    }
}
