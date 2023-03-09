//
//  MainViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/07.
//

import RxSwift
import RxCocoa
import CoreFoundation

final class MainViewModel: VM{

    
    var bag = DisposeBag()
    
    ///상단 바의 유무를 정할 Bool값
    ///false일 시 View가 보이고,
    ///true일 시 View를 숨긴다.
    let topViewHidden = BehaviorSubject<Bool>(value: false)
    
    struct Input{
       // let menuButtonTapped: Observable<Void>
    }
    
    struct Output{
        //let menuTapSign: Signal<Void>
    }
    
    func menuTapHidden(_ point: CGPoint){
        topViewHidden.onNext(true)
        
        print("aaa")
    }
    
    func transform(input: Input) -> Output {
        
        //let _menuButtonTapped = input.menuButtonTapped.map{Void()}
        
        return Output()
    }
}
