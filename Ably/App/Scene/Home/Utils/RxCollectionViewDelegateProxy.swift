//
//  RxCollectionViewDelegateProxy.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/18.
//

import UIKit
import RxCocoa

class RxCollectionViewDelegateProxy: DelegateProxy<UICollectionView, UICollectionViewDelegate>,DelegateProxyType,UICollectionViewDelegate{
    static func registerKnownImplementations() {
        self.register{ (data) -> RxCollectionViewDelegateProxy in
            RxCollectionViewDelegateProxy(parentObject: data, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: UICollectionView) -> UICollectionViewDelegate? {
        object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: UICollectionViewDelegate?, to object: UICollectionView) {
        object.delegate = delegate
    }
}
