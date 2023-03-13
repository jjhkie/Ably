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
    ///false일 시 View가 보이고, true일 시 View를 숨긴다.
    let _topViewHidden = BehaviorSubject<Bool>(value: false)
    
    struct Input{
    }
    
    struct Output{
        let topViewHidden: Observable<Bool>
    }
    

    
    func transform(input: Input) -> Output {
        
        return Output(topViewHidden: _topViewHidden.asObservable())
    }
}

//기능 구현
extension MainViewModel{
    //스크롤 이벤트에 따른 값 변화
    func menuTapHidden(_ value: Bool){
        _topViewHidden.onNext(value)
    }
}
