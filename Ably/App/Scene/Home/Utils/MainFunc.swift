//
//  MainFunc.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/09.
//

import Foundation
import UIKit

extension HomeViewController{
    
    //화면전환 시 navigationBar에 추가된 view의 유무
    func hiddenNavigationView(_ hidden: Bool){
        let addViews = self.navigationController?.navigationBar.subviews.filter({$0.tag == 100})
        addViews?.forEach{
            $0.isHidden = hidden
        }
    }
    
    //스크롤 이벤트에 따른 상단 View animation
    func topTabBarHidden(_ hiddenValue: Bool){
        if(hiddenValue){
            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut, animations: {
                self.rankingBar.snp.updateConstraints{
                    $0.top.equalToSuperview().offset(0)
                    
                }
                self.rankingBar.superview?.layoutIfNeeded()
                
                self.buttonBarView.snp.updateConstraints{
                    $0.top.equalToSuperview().offset(0)
                }
                self.buttonBarView.superview?.layoutIfNeeded()
                
                self.containerView.snp.updateConstraints{
                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
                }
                self.containerView.superview?.layoutIfNeeded()
            })
        }else if(!hiddenValue){
            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut, animations: {
                self.rankingBar.snp.updateConstraints{
                    $0.top.equalToSuperview().offset(self.navigationController?.navigationBar.frame.height ?? 0)
                    
                }
                self.rankingBar.superview?.layoutIfNeeded()
                
                self.buttonBarView.snp.updateConstraints{
                    $0.top.equalToSuperview().offset((self.navigationController?.navigationBar.frame.height ?? 0) * 2)
                }
                self.buttonBarView.superview?.layoutIfNeeded()
                
                self.containerView.snp.updateConstraints{
                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset((self.navigationController?.navigationBar.frame.height ?? 0) * 2)
                }
                
                self.containerView.superview?.layoutIfNeeded()
            })
        }
    }
}
