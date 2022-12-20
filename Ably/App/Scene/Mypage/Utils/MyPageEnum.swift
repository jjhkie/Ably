//
//  MyPageEnum.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/20.
//


enum MyPageEnum: CaseIterable{
    case center
    case list
    case privacy
    case service
    case laboratory
    case openlicense
    case version
    
    var contents: String{
        switch self{
        case .center:
            return "고객센터"
        case .list:
            return "공지사항"
        case .privacy:
            return "개인정보 처리방침"
        case .service:
            return "서비스 이용 약관"
        case .laboratory:
            return "실험실"
        case .openlicense:
            return "오픈소스라이센스"
        case .version:
            return "버전 정보"
        }
    }
}
