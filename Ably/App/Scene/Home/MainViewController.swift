//
//  MainViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import SnapKit
import XLPagerTabStrip
import Then
import RxSwift
import RxCocoa
import FirebaseDatabase

final class MainViewController: ButtonBarPagerTabStripViewController {
    //firebase
    var firebaseDB: DatabaseReference = Database.database().reference()
    private let menuBar = UIStackView().then{
        $0.axis = .horizontal
    }
    

    
    private let menuButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title: "text.justify"))
    }
    
    private let searchController = UISearchBar().then{
        $0.placeholder = "밸런타인 준비했나요?"
    }
    
    private let alertButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title: "bell"))
    }
    
    private let basketButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title:"basket"))
    }
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))


    
    private let rankingBar = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
    }
    
    private let popularLabel = UILabel().then{
        $0.text = "인기"
        
        $0.layer.cornerRadius = 10
    }
    private let rankingLabel = UILabel().then{
        $0.text = " 1 룩북"
    }
    private let totalRanking = UILabel().then{
        $0.text = "전체랭킹 >"
    }
    private let bag = DisposeBag()
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let scrollView = view.subviews.first(where: { $0 is UIScrollView}) as? UIScrollView{
            scrollView.rx.contentOffset
                .subscribe(onNext: {ab in
                    print(ab)
                })
                .disposed(by: bag)
        }
    }
    
    var scrollDifference: Double = 0.0
    var contentHeight = 50

    override func viewDidLoad() {
        self.tabBarCustom()

        super.viewDidLoad()
        var viewControllers = viewControllers

        for viewController in viewControllers {
            if let scrollView = viewController.scrollView {
                scrollView.rx.contentOffset
                    .subscribe(onNext: { [weak self] contentOffset in
                        // Handle contentOffset change here
                        print("Content offset: \(contentOffset) from viewController: \(viewController.title ?? "")")
                    })
                    .disposed(by: bag)
            }
        }
      
        self.navigationController?.navigationBar.backgroundColor = .green
        view.backgroundColor = .white
        bind()
        attribute()
        layout()
        //containerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let todayCo = TodayViewController(nibName: nil  , bundle:nil)

        return [todayCo, ShoppingMallViewController(),BrandController(),BeautyController(),PhoneCaseController(),CodiController(),BestController(),HotDealController()]
    }
}

extension MainViewController{

    func bind(){
        
        
        //menuButton 클릭 시 화면 이동
        menuButton.rx.tap
            .bind{
                //self.navigationController?.show(CollectionController(), sender: nil)
                let vc = CollectionController()
                vc.navigationController?.navigationBar.isHidden = false
                vc.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: bag)
//
//        buttonBarView.contentScrollView.rx.contentOffset
//            .map{
//                $0.y
//            }.bind{
//
//                print($0)
//            }
//            .disposed(by: bag)
  
        
        //firebaseTest
        alertButton.rx.tap
            .bind{
                //self.firebaseDB = Database.database().reference()
                self.firebaseDB.child("test").setValue(["name":"ABC","price":36000])
            }
            .disposed(by: bag)
        
        self.firebaseDB.observeSingleEvent(of: .value){snap in
            guard let data = snap.value as? [String:Any] else {return}
            print(data)
            /***
             ["test": {
                 name = ABC;
                 price = 36000;
             }]
             */
            let value = try! JSONSerialization.data(withJSONObject: Array(data.values), options: [])
            print(value)//30bytes
            do{
                let finalValue = try JSONDecoder().decode([Test].self, from: value)
                print("final")
                print(finalValue[0].name)
            }catch let error{
                print("error")
            }
           
        }
    }
    
    private func attribute(){
        //navigationController?.isNavigationBarHidden = true
        rankingBar.layoutMargins = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        rankingBar.isLayoutMarginsRelativeArrangement = true
        popularLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalRanking.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rankingLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        popularLabel.backgroundColor = .black
        popularLabel.textColor = .white
        
        //push 후 뒤로가기 버튼
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem

    }
    
    private func layout(){
        
        //TabBar Container Auto Layout
        //self.containerLayout()
        customView.backgroundColor = .red

        //navigationController?.navigationBar.addSubview(customView)
//        customView.snp.makeConstraints{
//            $0.top.equalToSuperview().inset(30)
//            $0.centerX.equalToSuperview()
//        }
        [menuButton,searchController,alertButton,basketButton].forEach{
            menuBar.addArrangedSubview($0)
        }
        
        [popularLabel,rankingLabel,totalRanking].forEach{
            rankingBar.addArrangedSubview($0)
        }
        
//        [menuBar,rankingBar].forEach{
//            view.addSubview($0)
//        }
        [rankingBar,buttonBarView].forEach{
            navigationController?.navigationBar.addSubview($0)
        }
        
        rankingBar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(self.navigationController?.navigationBar.frame.height ?? 0)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.navigationController?.navigationBar.frame.height ?? 0)
        }
        

        
//        menuBar.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-(self.navigationController?.navigationBar.frame.height ?? 0))
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(50)
//        }
        
//        rankingBar.snp.makeConstraints{
//            $0.top.equalTo(menuBar.snp.top).offset(contentHeight)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(50)
//        }
        
        buttonBarView.snp.makeConstraints{
            //$0.top.equalTo(rankingBar.snp.top).offset(contentHeight)
            $0.top.equalTo(rankingBar.snp.top).offset((self.navigationController?.navigationBar.frame.height ?? 0))
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.navigationController?.navigationBar.frame.height ?? 0)
        }
        containerView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset((self.navigationController?.navigationBar.frame.height ?? 0) * 2)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
}

//extension MainViewController: ChangeTopBarDelegate{
//    
//    func changeTopSetting(_ scrollValue: Double) {
//        if(scrollValue > scrollDifference && scrollValue - scrollDifference > 10){
//            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut, animations: {
//                self.rankingBar.snp.updateConstraints{
//                    $0.top.equalTo(self.menuBar.snp.top).offset(0)
//                }
//                self.rankingBar.superview?.layoutIfNeeded()
//                self.buttonBarView.snp.updateConstraints{
//                    $0.top.equalTo(self.rankingBar.snp.top).offset(0)
//                }
//                self.buttonBarView.superview?.layoutIfNeeded()
//            })
//        }else if (scrollValue < scrollDifference && scrollDifference - scrollValue > 10){
//            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut, animations: { [self] in
//                self.rankingBar.snp.updateConstraints{
//                    $0.top.equalTo(self.menuBar.snp.top).offset(contentHeight)
//                }
//                self.rankingBar.superview?.layoutIfNeeded()
//                self.buttonBarView.snp.updateConstraints{
//                    $0.top.equalTo(self.rankingBar.snp.top).offset(contentHeight)
//                }
//                self.buttonBarView.superview?.layoutIfNeeded()
//            })
//        }
//        scrollDifference = scrollValue
//        print("aaa")
//    }
//}


struct Test: Codable{
    let name: String
    let price: Int
}
