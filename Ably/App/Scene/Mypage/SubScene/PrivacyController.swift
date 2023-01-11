//
//  PrivacyController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/11.
//

import UIKit
final class PrivacyController : UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension PrivacyController{
    
    private func attribute(){
        self.navigationController?.setcommonBar("")
        self.title = "개인정보 처리방침"
    }
    
    
    private func layout(){
        
    }
}
