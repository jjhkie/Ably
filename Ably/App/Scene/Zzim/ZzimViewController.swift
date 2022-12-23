//
//  ZzimViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit

final class ZzimViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        attribute()
        layout()
        
    }
}

extension ZzimViewController{
    func bind(){
        
    }
    
    private func attribute(){
        //네비게이션 바 설정
        self.navigationController?.setcommonBar()
        self.navigationController?.navigationBar.topItem?.title = "찜"
        
        self.navigationController?.navigationItem.leadingButton()
    }
    
    private func layout(){
        
    }
}
