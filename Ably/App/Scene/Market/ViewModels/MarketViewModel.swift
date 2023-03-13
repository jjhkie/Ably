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

    let items = BehaviorSubject<[String]>(value: ["쇼핑몰", "셀럽", "브랜드", "라이프", "뷰티","디지털"])
        
    
    init(){
        tableData = [marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
                     marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
                     marketItem(title: "아뜨랑스", tag: ["러블리","오피스룩"], subscribeCount: 610000),
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
        let buttonCellData: Driver<[String]>
    }
    
    
    func transform(input: Input) -> Output {
        
        let cellData = Observable.just(tableData)
        
        return Output(
            tableCellData: cellData.asDriver(onErrorJustReturn: []),
            buttonCellData: items.asDriver(onErrorJustReturn: [])
        )
    }
}
