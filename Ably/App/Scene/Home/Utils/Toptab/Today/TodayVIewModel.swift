//
//  TodayVIewModel.swift
//  Ably
//
//  Created by 김진혁 on 2023/01/21.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class TodayViewModel: VM{
    var bag = DisposeBag()
    
    private let sections: [TodayModel] = [
        .NewYearSection(title: nil, items: [.NewYearSaleItem(image: UIColor.blue)]),
        .PagerViewSection(title: nil,items: [.PagerViewItem(image: UIColor.red),.PagerViewItem(image: UIColor.black),.PagerViewItem(image: UIColor.blue),.PagerViewItem(image: UIColor.yellow)]),
        .MenuViewSection(title: nil,
                         items: [.MenuViewItem(image: UIImage(systemName: "list")!, title: "전체보기"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "이벤트"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "실쿠폰뽑기"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "빠른출발"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "상의"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "디지털/핸드폰"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "아우터"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "패션소품"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "원피스/세트"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "주얼리"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "팬츠"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "문구점"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "신발"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "만원샵"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "스커트"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "뷰티"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "가방"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "방꾸미기"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "트레이닝"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "요즘뭐입지"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "빅사이즈"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "골라줘"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "홈웨어"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "푸드"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "언더웨어"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "기념일/선물"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "비치웨어"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "소셜"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "반려동물"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "제주도 여행"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "선물하기"),
                                 .MenuViewItem(image: UIImage(systemName: "list")!, title: "네일"),]),
        .FirstOrderBenefitsSection(title: "가입 후 3일간 첫 주문 990원", items: [
            .FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 "),
            .FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 "),
             .FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 ")
        ,.FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 ")
        ,.FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 ")
        ,.FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 ")
        ,.FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 ")
        ,.FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 ")
        ,.FirstOrderBenefitsItem(sale: "99%", price: "990", syagCheck: true, marketName: "마켓이름", ProductName: "[첫 구매 990원] 상품 이름 ")
        ]),
        .RecommendProductSection(title: "회원님을 위한 추천상품", items: [
            .RecommendProductItem(sale: "40%", price: "7,900", syagCheck: false, marketName: "마켓이름", ProductName: "[빠른출고] 상품 이름 "),
            .RecommendProductItem(sale: "40%", price: "7,900", syagCheck: false, marketName: "마켓이름", ProductName: "[빠른출고] 상품 이름 "),
            .RecommendProductItem(sale: "40%", price: "7,900", syagCheck: false, marketName: "마켓이름", ProductName: "[빠른출고] 상품 이름 ")
        ]),
        .HotTenSection(title: nil,items: [
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        .HotTenItem(sale: "25%", price: "21,150", syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
        ]),
        .SyagRecommendProductSection(title: "눈 깜짝할 사이, 샥-출발 상품", items: [
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
            .SyagRecommendProductItem(sale: "30%", price: "19,500", syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름")
        ]),
        .PlusSection(title: nil,items: [
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
            .PlusItem(sale: "40%", price: "21,500", syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500)
        ])
    ]
    
    private let sectionData = BehaviorRelay(value: [TodayModel]())
    
    struct Input{
        
    }
    
    struct Output{
        let cellData: Driver<[TodayModel]>
    }
    

    func transform(input: Input) -> Output {
        
        sectionData.accept(sections)
        return Output(cellData: sectionData.asDriver(onErrorJustReturn: []))
    }
}
