//
//  DetailViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/14.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewModel: VM{
    
    var sections: [DetailModel]
    init(){
        self.sections = [
            .ProductImage(title: "", items: [.ProductImageItem(image: UIImage(systemName: "bell")!)]),
            .MarketInfo(title: "", items: [.MarketInfoItem(logo: UIImage(systemName: "bell")!, marketName: "이지유니크", marketStyle: ["유니크","캐주얼","93%"], marketFavorites: 930000)])
        ]
    }
    
    var bag = DisposeBag()
    private let sectionData = BehaviorRelay(value:[DetailModel]())
    
    struct Input{
        
    }
    
    struct Output{
        let cellData: Driver<[DetailModel]>
    }
    

    func transform(input: Input) -> Output {
        
        sectionData.accept(sections)
        return Output(cellData: sectionData.asDriver(onErrorJustReturn: []))
    }
}

