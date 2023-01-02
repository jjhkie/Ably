//
//  ZzimViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/23.
//

import RxSwift
import UIKit
import RxRelay
import RxCocoa


final class ZzimViewModel:VM{
    var bag = DisposeBag()
    
    private let sections = [
        ZzimModel(header: "서랍 목록", items: [MainData(message: "a")]),
        ZzimModel(header: "a", items: [MainData(message: "a"),MainData(message: "a"),MainData(message: "a")]),
        ZzimModel(header: "a", items: [MainData(message: "a"),MainData(message: "a"),MainData(message: "a")])
    ]
    
    private let sectionSubject = BehaviorRelay(value: [ZzimModel]())
    
    init(){
        

    }
    

 
    

    
    struct Input{
        
    }
    
    struct Output{
        let cellData: Driver<[ZzimModel]>
    }

    func transform(input: Input) -> Output {
        
        sectionSubject.accept(sections)
        
        return Output(cellData: sectionSubject.asDriver(onErrorJustReturn: []))
    }
    
}
