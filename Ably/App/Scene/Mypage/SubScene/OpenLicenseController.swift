//
//  OpenLicenseController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/11.
//

import UIKit
final class OpenLicenseController : UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension OpenLicenseController{
    
    private func attribute(){
        self.navigationController?.setCommonBar("오픈소스 라이선스")
    }
    
    
    private func layout(){
        
    }
}
