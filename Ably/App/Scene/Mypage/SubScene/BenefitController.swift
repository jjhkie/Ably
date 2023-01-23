//
//  BenefitController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/09.
//

import UIKit


final class BenefitController : UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        attribute()
        layout()
    }
}

extension BenefitController{
    private func attribute(){
        self.navigationController?.setcommonBar()
        self.title = "회원혜택"
    }
    
    
    private func layout(){
        
    }
}
