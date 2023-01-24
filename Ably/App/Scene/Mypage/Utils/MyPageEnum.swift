//
//  MyPageEnum.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/20.
//

import UIKit


enum MyPageEnum: CaseIterable{
    
    case membership
    case recommend
    case help
    
    var description: String?{
        switch self{
        case .membership:
            return nil
        case .recommend:
            return "추천"
        case .help:
            return "도움말"
        }
    }
    var contents: [String]{
        switch self{
        case .membership:
            return ["","에이블리 회원만의 특별한 혜택 보러 가기"]
        case .recommend:
            return ["실험실","고민 투표, 골라줘"]
        case .help:
            return ["고객센터","공지사항","개인정보 처리방침","서비스 이용 약관","오픈소스라이센스","버전 정보"]
        }
    }

    var leadingImage: [UIImage?]{
        switch self{
        case .membership:
            return [UIImage(systemName: "pencil"),UIImage(systemName: "pencil")]
        case .recommend:
            return [UIImage(systemName: "pencil"),UIImage(systemName: "pencil")]
        case .help:
            return [UIImage(systemName: "pencil"),UIImage(systemName: "pencil"),UIImage(systemName: "pencil"),UIImage(systemName: "pencil"),UIImage(systemName: "pencil"),UIImage(systemName: "pencil")]
        }
    }
    
    var showController: [UIViewController?]{
        switch self{
        case .membership:
            return [nil,BenefitController()]
        case .recommend:
            return [LaboratoryController(),LaboratoryController()]
        case .help:
            return [CenterController(),ListController(),PrivacyController(),ServiceController(),OpenLicenseController(),BenefitController()]
        }
    }
}
