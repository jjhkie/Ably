//
//  CollectionController.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/03.
//

import UIKit


final class CollectionController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        view.backgroundColor = .white
        
        attribute()
        layout()
    }
}

extension CollectionController{
    private func attribute(){
        title = "모아보기"
    }
    
    private func layout(){
        
    }
}
