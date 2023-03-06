//
//  ButtonBarPagerTab+.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/06.
//

import XLPagerTabStrip
import SnapKit
import SnapKit

extension ButtonBarPagerTabStripViewController{
    
    func tabBarCustom(){

        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white

        settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 16.0)!
        settings.style.buttonBarItemLeftRightMargin = 0
        //settings.style.buttonBarItemTitleColor = .gray
        settings.style.buttonBarLeftContentInset = 10
        settings.style.buttonBarRightContentInset = 10
        settings.style.buttonBarMinimumLineSpacing = 500
        settings.style.buttonBarMinimumInteritemSpacing = 20 //Button Item Spacing
        settings.style.buttonBarItemsShouldFillAvailableWidth = false
        settings.style.selectedBarHeight = 3.0
        settings.style.selectedBarBackgroundColor = .black
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
            
            
        }
        

  
    }
    
    
    func containerLayout(){
        containerView.snp.makeConstraints {
            $0.top.equalTo(buttonBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
