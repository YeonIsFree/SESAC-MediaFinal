//
//  ViewController.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/03.
//

import UIKit
import SnapKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var dataList: [[TVSeries]] = [[], [], []]
    var targetDetail: TVSeries?
    var recommandList: [TVSeries] = []
    var castList: [Cast] = []
    
    // MARK: - UI Property
    
    let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureTableView()
        render()
    }
}

// MARK: - Networking Method

extension HomeViewController {
    func getData() {
        let group = DispatchGroup()
        
        // trend
        group.enter()
        DispatchQueue.global().async {
            DataManager.shared.fetchData(type: TVSeriesModel.self, api: .trend) { list in
                self.dataList[HomeSections.trend.rawValue] = list.results
                group.leave()
            }
        }
        
        // topRated
        group.enter()
        DispatchQueue.global().async {
            DataManager.shared.fetchData(type: TVSeriesModel.self, api: .topRated) { list in
                self.dataList[HomeSections.topRated.rawValue] = list.results
                group.leave()
            }
        }
        
        // popular
        group.enter()
        DispatchQueue.global().async {
            DataManager.shared.fetchData(type: TVSeriesModel.self, api: .popular) { list in
                self.dataList[HomeSections.popular.rawValue] = list.results
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.homeTableView.reloadData()
        }
    }
}

// MARK: - UICollectionView Delegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as? SeriesCollectionViewCell else { return UICollectionViewCell() }
        
        let item = dataList[collectionView.tag][indexPath.item]
        cell.configureSeriesCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.targetSeries = dataList[collectionView.tag][indexPath.item]
        present(vc, animated: true)
    }
}

// MARK: - UITableView Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeriesTableViewCell.identifier, for: indexPath) as? SeriesTableViewCell else { return UITableViewCell() }
        
        // 컬렉션 뷰에 Tag 설정
        cell.cellCollectionView.tag = indexPath.row
        
        // 테이블 뷰 타이틀 설정
        cell.sectionTitle.text = HomeSections(rawValue: indexPath.row)?.title
        
        // 컬렉션 뷰 Delegate 설정
        cell.cellCollectionView.dataSource = self
        cell.cellCollectionView.delegate = self
        cell.cellCollectionView.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        
        // 컬렉션 뷰 reload
        cell.cellCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
}

// MARK: - UITableView Configuration Method

extension HomeViewController {
    func configureTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(SeriesTableViewCell.self, forCellReuseIdentifier: SeriesTableViewCell.identifier)
    }
}

// MARK: - UI Configuration Method

extension HomeViewController {
    func render() {
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

