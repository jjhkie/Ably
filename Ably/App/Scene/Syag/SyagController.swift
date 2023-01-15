//
//  SyagController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/15.
//

import UIKit

final class SyagController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bind()
        attribute()
        layout()
    }
    
}

extension SyagController{
    
    func bind(){
        
    }
    
    private func attribute(){
        self.title = "샥-출발"
        self.navigationItem.leadingButton()
        self.navigationItem.trailingButton("magnifyingglass")

        navigationController?.setcommonBar("샥-출발")
    }
    
    private func layout(){
        
    }
}
