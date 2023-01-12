//
//  MyPageViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/22.
//

import RxSwift
import RxCocoa


final class MyPageViewModel: VM{

    struct Input{
        
    }
    
    struct Output{
        let tableCellData: Driver<[MyPageData]>
    }
    
    var bag = DisposeBag()
    
    var tableData: [MyPageData]
    
    
    init(){

        
        self.tableData = [MyPageData(header: "", items: (0..<MyPageEnum.allCases.count).map{MyData(title: MyPageEnum.allCases[$0].contents, image: MyPageEnum.allCases[$0].leadingImage!)})]
    }
    func transform(input: Input) -> Output {
        let cellData = Observable.just(tableData)
        
        return Output(tableCellData: cellData.asDriver(onErrorJustReturn: [])//table Cell 데이터
        )
    }
}


