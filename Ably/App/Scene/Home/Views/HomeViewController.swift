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


final class HomeViewController: ButtonBarPagerTabStripViewController {

    private let bag = DisposeBag()
    
    private let popularLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)).then{
        $0.text = "인기"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true // 경계선을 넘어가는 부분은 숨김 처리
    }
    
    private let rankingLabel = UILabel().then{
        $0.text = " 1 룩북"
        $0.textColor = .black
    }
    private let totalRanking = UILabel().then{
        $0.text = "전체랭킹 >"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
    }
    
    let rankingBar = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
        $0.tag = 100
    }
    
    private let fixedBottomView = UIButton(type: .system).then{
        $0.backgroundColor = .systemPink
        $0.setTitle("신규회원 딱 3일만! 인기상품 990원", for: .normal)
        $0.setImage(UIImage(systemName:"right_arrow"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }

    var viewModel = MainViewModel()
    
    override func loadView() {
        super.loadView()
        self.tabBarCustom()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        //navigationController?.navigationBar = MainCustomNavigationBar()
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

extension HomeViewController{
    
    func bind(_ VM: MainViewModel){
        
        let input = MainViewModel.Input()
        
        let output = VM.transform(input: input)
        
        //scroll에 따른 상단 뷰 애니메이션 기능
        output.topViewHidden
            .subscribe(onNext: {
                self.topTabBarHidden($0)
            })
            .disposed(by: bag)
        

        

    }
    
    private func attribute(){

        //navigationBar에 searchBar 추가
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        //NavigationBar trailing Button
        let image = UIImage(systemName: "bell")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5), resizingMode: .stretch)
        //let alertButton = UIBarButtonItem(image: image, style: .plain, target: .none, action: nil)
        let alertButton = UIButton().then{
            $0.setImage(image, for: .normal)
        }
        //let basketButton = UIBarButtonItem(image: image, style: .plain, target: .none, action: nil)
        let basketButton = UIButton().then{
            $0.setImage(image, for: .normal)
        }
        
        alertButton.tintColor = .black
        basketButton.tintColor = .black
        
        let barButtonItemStack = UIStackView(arrangedSubviews: [alertButton,basketButton]).then{
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
        
        
        let barButton = UIBarButtonItem(customView: barButtonItemStack)
        navigationItem.rightBarButtonItem = barButton
        
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
        
        view.addSubview(fixedBottomView)
        let height = tabBarController?.tabBar.subviews.filter({ $0 is UIControl }) as? [UIControl]
        let tabbarHeight = height?.first?.frame.height ?? 0
        fixedBottomView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(tabbarHeight)
        }
        
        rankingBar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(self.navigationController?.navigationBar.frame.height ?? 0)
            //$0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(self.navigationController?.navigationBar.frame.height ?? 0)
        }
        buttonBarView.snp.makeConstraints{
            $0.top.equalToSuperview().offset((self.navigationController?.navigationBar.frame.height ?? 0) * 2)
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


