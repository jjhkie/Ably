//
//  CenterController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/11.
//

import Foundation
import UIKit


final class CenterController : UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension CenterController{
    
    private func attribute(){
        self.navigationController?.setCommonBar("고객센터")
    }
    
    
    private func layout(){
        
    }
}
