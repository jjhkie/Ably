//
//  MainViewModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/07.
//

import RxSwift
import RxCocoa

final class MainViewModel: VM{

    
    var bag = DisposeBag()
    
    struct Input{
        let menuButtonTapped: Observable<Void>
    }
    
    struct Output{
        let menuTapSign: Signal<Void>
    }
    
    
    
    func transform(input: Input) -> Output {
        
        let _menuButtonTapped = input.menuButtonTapped.map{Void()}
        
        return Output(menuTapSign: _menuButtonTapped.asSignal(onErrorSignalWith: .empty()))
    }
}
