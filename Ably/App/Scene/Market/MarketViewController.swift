//
//  MarketViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit

final class MarketViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        attribute()
        layout()
    }
}


extension MarketViewController{
    func bind(){
        
    }
    
    func attribute(){
        //NavigationBar
        self.navigationController?.navigationBar.topItem?.title = "마켓"


        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func layout(){
        
    }
}
