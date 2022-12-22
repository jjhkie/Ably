//
//  ViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/22.
//

import RxSwift

// ViewModel 구조
protocol VM {
    associatedtype Input
    associatedtype Output
    
    var bag: DisposeBag{ get set }
    
    func transform(input: Input) -> Output
}
