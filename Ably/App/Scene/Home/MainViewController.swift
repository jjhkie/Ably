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

    
    private let alertButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title: "bell"))
    }
    
    private let basketButton = UIButton().then{
        $0.configuration = .buttonStyle(style: .image(title:"basket"))
    }

    
    private let rankingBar = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
        $0.tag = 100
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
    
    var viewModel = MainViewModel()

    var scrollDifference: Double = 0.0
    var contentHeight = 50

    override func viewDidLoad() {
        self.tabBarCustom()

        super.viewDidLoad()

        view.backgroundColor = .white
        bind(viewModel)
        attribute()
        layout()
        //containerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        let addViews = self.navigationController?.navigationBar.subviews.filter({$0.tag == 100})
        print(addViews)
        addViews?.forEach{
            print("hidden 작동")
            $0.isHidden = false
        }

    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let todayCo = TodayViewController()
        todayCo.parentViewModel = viewModel
        
        
        return [todayCo, ShoppingMallViewController(),BrandController(),BeautyController(),PhoneCaseController(),CodiController(),BestController(),HotDealController()]
    }
}

extension MainViewController{

    func bind(_ VM: MainViewModel){
        
        let input = MainViewModel.Input()
        
        let output = VM.transform(input: input)
        
//        VM.topViewHidden
//            .subscribe(onNext: { value in
//                if(value){
//                    UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseOut, animations: {
//                                    self.rankingBar.snp.updateConstraints{
//                                        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
//
//                                    }
//                                    self.rankingBar.superview?.layoutIfNeeded()
////                                    self.buttonBarView.snp.updateConstraints{
////                                        $0.top.equalTo(self.rankingBar.snp.top).offset(0)
////                                    }
////                                    self.buttonBarView.superview?.layoutIfNeeded()
//                                })
//                }
//            })
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
        navigationController?.setCommonBar("abc")
        //navigationController?.isNavigationBarHidden = true
        rankingBar.layoutMargins = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        rankingBar.isLayoutMarginsRelativeArrangement = true
        popularLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalRanking.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rankingLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        popularLabel.backgroundColor = .black
        popularLabel.textColor = .white
        buttonBarView.tag = 100
        
        //push 후 뒤로가기 버튼
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem

    }
    
    private func layout(){
        
        ///랭킹 스택뷰
        [popularLabel,rankingLabel,totalRanking].forEach{
            rankingBar.addArrangedSubview($0)
        }
        
        [rankingBar,buttonBarView].forEach{
            self.navigationController?.navigationBar.addSubview($0)
        }
        
        rankingBar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(self.navigationController?.navigationBar.frame.height ?? 0)
            //$0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.navigationController?.navigationBar.frame.height ?? 0)
        }
        
        
        buttonBarView.snp.makeConstraints{
            $0.top.equalToSuperview().offset((self.navigationController?.navigationBar.frame.height ?? 0) * 2)
            //$0.center.equalToSuperview()
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
