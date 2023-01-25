//
//  LaboratoryViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/25.
//

import RxSwift
import RxCocoa

final class LaboratoryViewModel: VM{
    
    var bag = DisposeBag()
    var tableData: [LaboratoryModel]
    
    struct Input {
        
    }
    
    struct Output {
        let tableCellData: Driver<[LaboratoryModel]>
    }
    
    init(){
        //UserDefaults를 사용하여 저장할 데이터
        self.tableData = [
            LaboratoryModel(title: "찜할 때마다 서랍 선택", subContent: "상품 찜을 할 때마다 서랍 선택을 하는 것이 번거로우셨다면, 선택 기능을 꺼두실 수 있어요. 이 기능을 끄시면 찜한 상품은 기본 서랍에 담기게 됩니다.", toggleButton: true),
            LaboratoryModel(title: "움직이는 이미지(gif) 기능", subContent: "상품 이미지를 멈추고 싶다면, 움직이는 이미지(gif)기능을 꺼주세요", toggleButton: true),
            LaboratoryModel(title: "화면 터치 시 진동 기능", subContent: "", toggleButton: true)
        ]
    }

    
    func transform(input: Input) -> Output {
        let cellData = Observable.just(tableData)
        return Output(tableCellData: cellData.asDriver(onErrorJustReturn: []))
    }
    
}
    
    
    struct LaboratoryModel{
        let title: String
        let subContent: String
        let toggleButton: Bool
    }
