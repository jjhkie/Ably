//
//  MarketViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/12.
//

import RxSwift
import RxCocoa


final class MarketViewModel:VM{
    var bag = DisposeBag()
    
    var tableData: [String]

    init(){
        tableData = ["a","aa","aaa"]
    }

    struct Input {
        
    }
    
    struct Output {
        let tableCellData: Driver<[String]>
    }
    
    
    func transform(input: Input) -> Output {
        
        let cellData = Observable.just(tableData)
        
        return Output(tableCellData: cellData.asDriver(onErrorJustReturn: []))
    }
}
