//
//  MyPageTableDelegate.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/09.
//


import UIKit

extension MypageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 100
        case 1:
            return 80
        default:
            return 50
            
        }
    }
}
