//
//  MypageViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit

final class MypageViewController: UIViewController{

    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        attribute()
        layout()
    }
}

extension MypageViewController{
    
    func bind(){
        tableView.dataSource = self
    }
    
    func attribute(){
        //NavigationBar
        self.navigationController?.navigationBar.topItem?.title = "마이페이지"
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
        tableView.register(MyPageCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    func layout(){
        [tableView].forEach{
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MypageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyPageEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as? MyPageCell else {return UITableViewCell()}
        
        cell.setData(indexPath)
        return cell
    }
    
}
