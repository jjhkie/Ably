//
//  MyPageEnum.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/20.
//

import UIKit


enum MyPageEnum: CaseIterable{
    case banner
    case benefit
    case laboratory
    case vote
    case center
    case list
    case privacy
    case service
    case openlicense
    case version
    
    var contents: String{
        switch self{
        case .banner:
            return ""
        case .benefit:
            return "에이블리 회원만의 특별한 혜택 보러 가기"
        case .laboratory:
            return "실험실"
        case .vote:
            return "고민 투표, 골라줘"
        case .center:
            return "고객센터"
        case .list:
            return "공지사항"
        case .privacy:
            return "개인정보 처리방침"
        case .service:
            return "서비스 이용 약관"

        case .openlicense:
            return "오픈소스라이센스"
        case .version:
            return "버전 정보"
        }
    }
    
    var leadingImage: UIImage?{
        switch self{
        case .banner:
            return UIImage(systemName: "pencil")
        case .benefit:
            return UIImage(systemName: "pencil")
        case .laboratory:
            return UIImage(systemName: "eraser")
        case .vote:
            return UIImage(systemName: "eraser")
        case .center:
            return UIImage(systemName: "eraser")
        case .list:
            return UIImage(systemName: "pencil")
        case .privacy:
            return UIImage(systemName: "eraser")
        case .service:
            return UIImage(systemName: "pencil")

        case .openlicense:
            return UIImage(systemName: "pencil")
        case .version:
            return UIImage(systemName: "eraser")
        }
    }
    
    var showController: UIViewController?{
        switch self{
            
        case .banner:
            return nil
        case .benefit:
            return BenefitController()
        case .laboratory:
            return LaboratoryController()
        case .vote:
            return LaboratoryController()
        case .center:
            return CenterController()
        case .list:
            return ListController()
        case .privacy:
            return PrivacyController()
        case .service:
            return ServiceController()

        case .openlicense:
            return OpenLicenseController()
        case .version:
            return BenefitController()
        }
    }
    
}
