//
//  ServiceController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/11.
//

import UIKit
final class ServiceController : UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension ServiceController{
    
    private func attribute(){
        self.navigationController?.setcommonBar("")
        self.title = "서비스 이용약관"
    }
    
    
    private func layout(){
        
    }
}
