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
    
    var sections: [TodayModel]
    
    init(){
        
        self.sections = [
            .PagerViewSection(title: "",items: [.PagerViewItem(image: UIColor.red),.PagerViewItem(image: UIColor.black),.PagerViewItem(image: UIColor.blue),.PagerViewItem(image: UIColor.yellow)]),
            .MenuViewSection(title: "",
                             items: [.MenuViewItem(image: UIImage(systemName: "bell")!, title: "전체보기"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "이벤트"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "실쿠폰뽑기"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "빠른출발"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "상의"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "디지털/핸드폰"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "아우터"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "패션소품"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "원피스/세트"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "주얼리"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "팬츠"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "문구점"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "신발"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "만원샵"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "스커트"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "뷰티"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "가방"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "방꾸미기"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "트레이닝"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "요즘뭐입지"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "빅사이즈"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "골라줘"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "홈웨어"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "푸드"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "언더웨어"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "기념일/선물"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "비치웨어"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "소셜"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "반려동물"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "제주도 여행"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "선물하기"),
                                     .MenuViewItem(image: UIImage(systemName: "bell")!, title: "네일"),]),
            .FirstOrderBenefitsSection(title: "가입 후 3일간 첫 주문 990원", items: [
                .FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 "),
                .FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 "),
                .FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 ")
                ,.FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 ")
                ,.FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 ")
                ,.FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 ")
                ,.FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 ")
                ,.FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 ")
                ,.FirstOrderBenefitsItem(sale: "99%", price: 990, syagCheck: true, marketName: "마켓이름", productName: "[첫 구매 990원] 상품 이름 ")
            ]),
            .RecommendProductSection(title: "회원님을 위한 추천상품", items: [
                .RecommendProductItem(sale: "40%", price: 7900, syagCheck: false, marketName: "마켓이름", ProductName: "[빠른출고] 상품 이름 "),
                .RecommendProductItem(sale: "40%", price: 7900, syagCheck: false, marketName: "마켓이름", ProductName: "[빠른출고] 상품 이름 "),
                .RecommendProductItem(sale: "40%", price: 7900, syagCheck: false, marketName: "마켓이름", ProductName: "[빠른출고] 상품 이름 ")
            ]),
            .HotTenSection(title: "",items: [
                .HotTenItem(sale: "25%", price: 21150, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21150, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21150, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21150, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
                .HotTenItem(sale: "25%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "[sns반응최고] 상품 이름", totalSale: 3945),
            ]),
            .SyagRecommendProductSection(title: "눈 깜짝할 사이, 샥-출발 상품", items: [
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름"),
                .SyagRecommendProductItem(sale: "30%", price: 19500, syagCheck: true, marketName: "마켓이름", ProductName: "[샥 출발 가능] 상품 이름")
            ]),
            .PlusSection(title: "",items: [
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500),
                .PlusItem(sale: "40%", price: 21500, syagCheck: true, marketName: "마켓이름", ProductName: "상품이름", totalSale: 16500)
            ])
        ]
    }
    
    private let sectionData = BehaviorRelay(value: [TodayModel]())
    
    var scrollData = BehaviorSubject<Bool>(value: false)
    
    struct Input{
        // scrollOffSet값 변경될 때 값 감지
        let scrollEvent : Observable<CGFloat>
    }
    
    struct Output{
        //셀 기본 데이터
        let cellData: Driver<[TodayModel]>
        //스크롤 차이값에 따른 bool값
        let differenceValue: Observable<Bool>
        
    }
    
    //마지막 스크롤 위치
    var lastContentOffset: CGFloat = .zero
    

    func transform(input: Input) -> Output {
        
        input.scrollEvent
            .subscribe(onNext: { currentValue in
                let scrollDifference = currentValue - self.lastContentOffset
                self.lastContentOffset = currentValue
                
                if(scrollDifference > 5){
                    self.scrollData.onNext(true)
                }else if scrollDifference < -5{
                    self.scrollData.onNext(false)
                }
                //print(self.scrollData)
                //print(scrollDifference)
            })
            .disposed(by: bag)
//        input.scrollEvent
//            .bind(to: _isScrolledEvent)
//            .disposed(by: bag)
        
        
        sectionData.accept(sections)
        return Output(cellData: sectionData.asDriver(onErrorJustReturn: []),
                      differenceValue: scrollData.asObservable())
    }
}
