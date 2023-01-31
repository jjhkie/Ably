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
    
    var tableData: [marketItem]

    init(){
        tableData = [marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
                     marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
                     marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
                     marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
                     marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
                     marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000)]

    }

    struct Input {
        
    }
    
    struct Output {
        let tableCellData: Driver<[marketItem]>
    }
    
    
    func transform(input: Input) -> Output {
        
        let cellData = Observable.just(tableData)
        
        return Output(tableCellData: cellData.asDriver(onErrorJustReturn: []))
    }
}
