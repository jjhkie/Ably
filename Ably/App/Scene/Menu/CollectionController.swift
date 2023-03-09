//
//  CollectionController.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/03.
//

import UIKit


final class CollectionController: UIViewController{
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // NavigationBar에 추가된 view 숨기기
        let addViews = self.navigationController?.navigationBar.subviews.filter({$0.tag == 100})
        print(addViews)
        addViews?.forEach{
            print("hidden 작동")
            $0.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hidesBottomBarWhenPushed = true
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.topItem?.title = "모아보기"
        view.backgroundColor = .blue
        
        attribute()
        layout()
    }
}

extension CollectionController{
    private func attribute(){
       
    }
    
    private func layout(){
        
    }
}
