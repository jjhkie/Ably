//
//  SyagController.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/15.
//

import UIKit
import SnapKit

final class SyagController: UIViewController{
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: syagLayout()).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.dataSource = self
        bind()
        attribute()
        layout()
    }
    
    private let testDataSource: [TestSection] = [
        .first((1...1).map(String.init).map(TestSection.FirstItem.init(value: ))),
        .second((1...17).map(String.init).map(TestSection.SecondItem.init(value: ))),
        .third((1...20).map(String.init).map(TestSection.ThirdItem.init(value: ))),
        .fourth((1...10).map(String.init).map(TestSection.FourthItem.init(value: ))),
    ]
    
}


extension SyagController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.testDataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.testDataSource[section]{
            
        case let .first(items):
            return items.count
        case let .second(items):
            return items.count
        case let .third(items):
            return items.count
        case let .fourth(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = .blue
        
        return cell
    }
    
}

extension SyagController{
    
    func bind(){
        
    }
    
    private func attribute(){
        navigationController?.setCommonBar("샥-출발")
        navigationController?.leadingButton()
        navigationController?.trailingButton("magnifyingglass")

    }
    
    private func layout(){
        view.addSubview(collectionView)
        
        
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
