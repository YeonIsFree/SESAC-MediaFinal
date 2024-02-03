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
    
     // MARK: - UI Property
    
    let homeTableView: UITableView = {
        let tableView = UITableView()
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
        
        // 이미지 설정
        if let imagePath = item.poster_path,
           let imageString = URL(string: Endpoint.baseImageURL + imagePath) {
            print(imagePath)
            cell.cellImageView.kf.setImage(with: imageString)
        }
        
        // 작품명
        cell.cellLabel.text = item.name
        
        return cell
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
        
        // 타이틀
        cell.sectionTitle.text = HomeSections(rawValue: indexPath.row)?.title
        
        // 컬렉션 뷰
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

