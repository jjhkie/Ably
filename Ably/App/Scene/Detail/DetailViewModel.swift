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
            .ProductImage(title: "", items: [.ProductImageItem(image: UIImage(systemName: "bell")!, marketName: "통통", marketStyle: ["심플베이직","캐주얼"], marketFavorites: 86000, productName: "[첫 구매 990원 ] 밴딩 주름 플리츠 롱 스커트", price: 23500, sale: 95)]),
            .DeliveryInfo(title: "", itmes: [.DeliveryInfoItem(syag: true)]),
            .ProductInfo(title: "", items: [.ProductInfoItem(text: "abc")])
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

