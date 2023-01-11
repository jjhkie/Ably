//
//  LaboratoryController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/11.
//

import UIKit
final class LaboratoryController : UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension LaboratoryController{
    
    private func attribute(){
        self.navigationController?.setcommonBar("")
        self.title = "실험실"
    }
    
    
    private func layout(){
        
    }
}

