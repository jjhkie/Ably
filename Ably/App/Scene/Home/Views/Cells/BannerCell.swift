//
//  BannerCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/02.
//

import UIKit
import FSPagerView
import SnapKit

final class BannerCell: UICollectionViewCell{

    private let image: [UIColor] = [.red,.blue,.green]
    private let testLabel = UILabel()
    
    private let bannerImage = FSPagerView()
    private let bannerControl = FSPageControl()
    override init(frame: CGRect) {
        super.init(frame: frame)
        bannerImage.dataSource = self
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BannerCell: FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        image.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = bannerImage.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.backgroundColor = image[index]
        return cell
    }
    
}

extension BannerCell{
    private func attribute(){
        bannerImage.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        bannerImage.automaticSlidingInterval = 4.0
        bannerImage.isInfinite = true
        
        bannerControl.contentHorizontalAlignment = .right
    }
    private func layout(){
        [bannerImage,bannerControl].forEach{
            contentView.addSubview($0)
        }
        bannerControl.numberOfPages = 10
        
        bannerImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bannerControl.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bannerImage.snp.bottom)
            $0.height.width.equalTo(50)
        }
    }
}
