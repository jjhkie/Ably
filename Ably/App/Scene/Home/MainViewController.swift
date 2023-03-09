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
    
    private let bag = DisposeBag()
    
    let rankingBar = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
        $0.tag = 100
    }
    
    private let popularLabel = UILabel().then{
        $0.text = "인기"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true // 경계선을 넘어가는 부분은 숨김 처리
    }
    private let rankingLabel = UILabel().then{
        $0.text = " 1 룩북"
    }
    private let totalRanking = UILabel().then{
        $0.text = "전체랭킹 >"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
    }

    var viewModel = MainViewModel()
    
    override func loadView() {
        super.loadView()
        self.tabBarCustom()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white
        attribute()
        layout()
        bind(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNavigationView(false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hiddenNavigationView(true)
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
        
        //scroll에 따른 상단 뷰 애니메이션 기능
        output.topViewHidden
            .subscribe(onNext: {
                self.topTabBarHidden($0)
            })
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
                //let finalValue = try JSONDecoder().decode([Test].self, from: value)
                print("final")
                //print(finalValue[0].name)
            }catch let error{
                print("error")
            }
            
        }
    }
    
    private func attribute(){
        popularLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalRanking.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rankingLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
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
            $0.leading.trailing.equalToSuperview().inset(15)
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


