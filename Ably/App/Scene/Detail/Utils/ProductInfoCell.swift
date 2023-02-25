//
//  ProductInfoCell.swift
//  Ably
//
//  Created by 김진혁 on 2023/02/18.
//

import UIKit
import SnapKit
import Then
import FSPagerView

final class ProductInfoCell: UICollectionViewCell{
    
    
    let imageArrays = ["1.jpg","2.jpg","3.jpg"]
    
    //FSPagerView
    private var pagerView: FSPagerView! = FSPagerView().then{
        $0.backgroundColor = .blue
        $0.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        $0.itemSize = FSPagerView.automaticSize
    }
    
    //FSPagerControl
    private let pagerViewControl = FSPageControl().then{
       // $0.numberOfPages = self.imageArrays.count
        $0.contentHorizontalAlignment = .center
        $0.itemSpacing = 10
        $0.interitemSpacing = 10
    }
    
    let marketInfoView = UIStackView().then{
        $0.layoutMargins = UIEdgeInsets(top: 10, left: .zero, bottom: 10, right: .zero)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    let line = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    // Market Main Round Image
    let marketImage = UIImageView().then{
        $0.roundImageView(50.0)
    }
    
    let marketTitleView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 3
    }
    
    // 우측 버튼
    let favoriteButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .favorite)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    ///Cell 전체 StackView
    private let fullStack = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    private let productStack = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 10
        $0.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 30, right: 0)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    ///상품 이름
    private let productName = UILabel()
    
    ///상품 가격 및 Icon StackView
    private let priceInfoStack = UIStackView().then{
        $0.axis = .horizontal
        //$0.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    ///상품 가격 및 할인
    private let priceInfoLabel = UILabel()
    
    ///카카오톡 Icon
    private let kakaoTalkBt = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title: "bell"))
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    //공유 ICon
    private let shareBt = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title: "bell"))
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    ///15,000원 미만 가격에만 생성될 Label
    private let grayBox = BasePaddingLabel().then{
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.text = "다른 상품을 15,000원 이상 함께 담아주세요"
        $0.font = .systemFont(ofSize: 12)
        $0.backgroundColor = .lightGray
        $0.textColor = .gray
    }
    
    ///할인 쿠폰 박스
    private let couponBt = UIButton().then{
        $0.layer.cornerRadius = 5
        $0.contentHorizontalAlignment = .left
        var config = UIButton.Configuration.plain()
        config.title = "최대 2,000원 할인 쿠폰받기"
        config.image = UIImage(systemName: "chevron.compact.down")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.imagePadding = 100
        config.imagePlacement = .trailing
        $0.configuration = config
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.pagerView.dataSource = self
        contentView.backgroundColor = .white
        attribute()
        layout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductInfoCell{

    func setText(marketImage: UIImage, marketName: String, marketStyle: [String],marketFavorites:Int, productName: String){
        
        self.productName.text = productName
        marketTitleView.verticalDoubleLine(marketName,marketStyle)
    }
    
    func setData(count: Int, sale: Int){
        let discountPrice = Int(count * ((100 - sale) / 100))
        priceInfoLabel.text = "\(sale)% \(discountPrice)원 \(count)원"
        
        let attributedString = NSMutableAttributedString(string: priceInfoLabel.text ?? "")
        _ = priceInfoLabel.text?.components(separatedBy: " ").enumerated().map{index, value in
            switch index{
            case 0:
                attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 25), range: ((priceInfoLabel.text ?? "") as NSString).range(of: value))
                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: ((priceInfoLabel.text ?? "") as NSString).range(of: value))
            case 1:
                attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 25), range: ((priceInfoLabel.text ?? "") as NSString).range(of: value))
            default:
                
                attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: ((priceInfoLabel.text ?? "") as NSString).range(of: value))
                attributedString.addAttribute(.baselineOffset, value: 0, range: ((priceInfoLabel.text ?? "") as NSString).range(of: value))
                attributedString.addAttribute(.strikethroughStyle, value: 1, range: ((priceInfoLabel.text ?? "") as NSString).range(of: value))
                attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: ((priceInfoLabel.text ?? "") as NSString).range(of: value))
            }
        }
        
        priceInfoLabel.attributedText = attributedString
    }
    
    private func attribute(){
       
        priceInfoStack.distribution = .fill
        couponBt.layer.borderWidth = 1
        couponBt.layer.borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        [fullStack].forEach{
            $0.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10)

            $0.isLayoutMarginsRelativeArrangement = true
        }
        
    }
    
    private func layout(){
        
        [marketImage,marketTitleView,favoriteButton].forEach{
            marketInfoView.addArrangedSubview($0)
        }
        
        [priceInfoLabel,kakaoTalkBt,shareBt].forEach{
            priceInfoStack.addArrangedSubview($0)
        }
        
        [productName,priceInfoStack,grayBox,couponBt].forEach{
            productStack.addArrangedSubview($0)
        }

        
        [marketInfoView,productStack].forEach{
            fullStack.addArrangedSubview($0)
        }
        
        [pagerView,fullStack].forEach{
            contentView.addSubview($0)
        }
        
        marketImage.snp.makeConstraints{
            $0.height.width.equalTo(50)
        }
        
        pagerView.snp.makeConstraints{
            $0.top.equalTo(contentView)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.frame.height * 0.6)
        }

        
        fullStack.snp.makeConstraints{
            $0.top.equalTo(pagerView.snp.bottom)
            //$0.top.equalTo(pagerView.snp.bottom)
            $0.leading.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        

    }
}


extension ProductInfoCell: FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageArrays.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageArrays[index])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
}
