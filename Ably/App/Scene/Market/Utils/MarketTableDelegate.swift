//
//  MarketTableDelegate.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/02.
//
import UIKit


extension MarketViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
