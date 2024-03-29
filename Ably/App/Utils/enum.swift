//
//  enum.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/07.
//
import UIKit

enum TabBarItem: CaseIterable{
    case home
    case market
    case syag
    case zzim
    case mypage
    
    //TabBar Title
    var title: String{
        switch self{
        case .home:
            return "홈"
        case .market:
            return "마켓"
        case .syag:
            return "샥-출발"
        case .zzim:
            return "찜"
        case .mypage:
            return "마이페이지"

        }
    }
    
    //TabBar Icon
    var icon: (default: UIImage?, selected: UIImage?){
        switch self{
        case .home:
            return (UIImage(systemName: "house"), UIImage(systemName: "house.fill"))
        case .market:
            return (UIImage(systemName: "window.awning"), UIImage(systemName: "window.awning"))
        case .syag:
            return (UIImage(systemName: "person"), UIImage(systemName: "person.fill"))
        case .zzim:
            return (UIImage(systemName: "heart"), UIImage(systemName: "heart.fill"))
        case .mypage:
            return (UIImage(systemName: "person"), UIImage(systemName: "person.fill"))

        }
    }
    
    //TabBar ViewController
    var controller: UIViewController{
        switch self{
        case .home:
            return UINavigationController(rootViewController: HomeViewController())
        case .market:
            return UINavigationController(rootViewController: MarketViewController())
        case .syag:
            return UINavigationController(rootViewController: SyagController())
        case .zzim:
            return UINavigationController(rootViewController: ZzimViewController())
        case .mypage:
            return UINavigationController(rootViewController: MypageViewController())

        }
    }
}

enum TopButtonItem: Int{
    case menuBt
    case alertBt
    case basketBt
    
    
    var imageTitle: String{
        switch self{
            
        case .menuBt:
            return "text.justify"
        case .alertBt:
            return "bell"
        case .basketBt:
            return "basket"
        }
    }
}

//Remove - Test
enum TestSection{
    case first([FirstItem])
    case second([SecondItem])
    case third([ThirdItem])
    case fourth([FourthItem])
    
    struct FirstItem{
        let value: String
    }
    
    struct SecondItem{
        let value: String
    }
    
    struct ThirdItem{
        let value: String
    }
    
    struct FourthItem{
        let value: String
    }
}
