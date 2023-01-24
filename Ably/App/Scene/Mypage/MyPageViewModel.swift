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
    //var tableDatas: [MyData]
    
    
    init(){
        self.tableData = (0..<MyPageEnum.allCases.count).map{count in
            MyPageData(header: MyPageEnum.allCases[count].description ?? "", items: (0..<MyPageEnum.allCases[count].contents.count).map{value in
                MyData(title: MyPageEnum.allCases[count].contents[value], image: MyPageEnum.allCases[count].leadingImage[value]!)
            })
        }
    }

    
    func transform(input: Input) -> Output {
        let cellData = Observable.just(tableData)
        
        return Output(tableCellData: cellData.asDriver(onErrorJustReturn: [])//table Cell 데이터
        )
    }
}


