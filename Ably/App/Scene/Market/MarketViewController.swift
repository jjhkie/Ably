//
//  MarketViewController.swift
//  Ably
//
//  Created by 김진혁 on 2022/12/04.
//

import UIKit
import Then
import RxSwift
import SnapKit

final class MarketViewController: UIViewController{
    
    let bag = DisposeBag()
    
    private let segmentControl = UISegmentedControl(items: ["랭킹","즐겨찾기"]).then{
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.register(CellReusable.marketCell)
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: favoriteLayout()).then{
        $0.isHidden = true
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
    
    private let testDataSource: [TestSection] = [
        .first((1...1).map(String.init).map(TestSection.FirstItem.init(value:))),
        .second((1...3).map(String.init).map(TestSection.SecondItem.init(value: )))
    ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind(MarketViewModel())
        attribute()
        layout()
        
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nav = navigationController{
            navigationController
        }
        
    }
    
    var shouldHideFirstView: Bool? {
      didSet {
        guard let shouldHideFirstView = self.shouldHideFirstView else { return }
        self.tableView.isHidden = shouldHideFirstView
        self.collectionView.isHidden = !self.tableView.isHidden
      }
    }
}

//Remove
extension MarketViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.testDataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.testDataSource[section]{
            
        case let .first(items):
            return items.count
        case let .second(items):
            return items.count
        case .third(_):
            return 0
        case .fourth(_):
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = .blue
            return cell
        
    }
    
    
}

extension MarketViewController{
    func bind(_ VM: MarketViewModel){
        
        let input = MarketViewModel.Input()
        
        let output = VM.transform(input: input)
        
        output.tableCellData
            .drive(tableView.rx.items){tableView,index,data in
                let cell = self.tableView.dequeue(CellReusable.marketCell)
                cell?.setData(data, index)
                return cell!
            }
            .disposed(by: bag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: bag)
        
    }
    

    
    func attribute(){
        //NavigationBar
        navigationController?.setCommonBar("마켓")
        navigationController?.trailingButton("abc")
        title = "마켓"
        
        
        //segMentControl
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .white
        segmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)

        //tableView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl){
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    func layout(){
        [segmentControl,tableView,collectionView].forEach{
            view.addSubview($0)
        }
        segmentControl.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

