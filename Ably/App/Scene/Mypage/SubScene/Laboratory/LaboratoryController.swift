//
//  LaboratoryController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/11.
//

///TODO
///Header / first LIne 에 Image 추가
///데이터를 UserDefaults에 넣어서 호출하기
///첫 번째 Cell의 separator Line 제거

import UIKit
import Then
import RxSwift
import SnapKit

final class LaboratoryController : UIViewController{
    
    let bag = DisposeBag()

    private let tableView = UITableView().then{
        $0.backgroundColor = .white
        
        $0.register(CellReusable.commonCell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind(LaboratoryViewModel())
        attribute()
        layout()
    }
    
    
}

extension LaboratoryController{
    
    func bind(_ VM: LaboratoryViewModel){
        
        let input = LaboratoryViewModel.Input()
        
        let output = VM.transform(input: input)
        
        output.tableCellData
            .drive(tableView.rx.items){view, index, data in
                let cell = self.tableView.dequeue(CellReusable.commonCell)
                if(index == 0){
                    cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                }else{
                    cell!.separatorInset = UIEdgeInsets.zero // separator line의 앞 공간 제거
                }
                
                var content = cell?.defaultContentConfiguration()
                content?.text = data.title
                content?.secondaryText = data.subContent
                content?.secondaryTextProperties.color = .gray
                
                
                let toggleButton = UISwitch(frame: CGRectZero) as UISwitch
                toggleButton.onTintColor = .red
                toggleButton.isOn = data.toggleButton

                cell?.accessoryView = toggleButton
                //content?.attributedText = data.subContent
               
                
                
                cell?.contentConfiguration = content
                return cell!
            }
            .disposed(by: bag)
        
        
    }
    
    private func attribute(){
        
        self.navigationController?.trailingButton("bell")
    }
    
    
    private func layout(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}



