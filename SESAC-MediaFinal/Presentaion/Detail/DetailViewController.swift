//
//  DetailViewController.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/04.
//

import UIKit

class DetailViewController: UIViewController {
    
    var targetSeries: TVSeries? // 이전 화면에서 넘어온 눌린 작품
    var recommandList: [TVSeries] = []
    var castList: [Cast] = []
    
    // MARK: - UI Property
    
    let detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let targetSeries {
            getDetailData(targetSeries.id)
        }
        
        configureTableView()
        render()
    }
}

extension DetailViewController {
    func getDetailData(_ id: Int) {
        let group = DispatchGroup()
        
        // recommand
        group.enter()
        DispatchQueue.global().async {
            DataManager.shared.fetchData(type: TVSeriesModel.self, api: .recommand(id: id)) { list in
                self.recommandList = list.results
                group.leave()
            }
        }
        
        // cast
        group.enter()
        DispatchQueue.global().async {
            DataManager.shared.fetchData(type: CastModel.self, api: .cast(id: id)) { list in
                self.castList = list.cast
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.detailTableView.reloadData()
        }
    }
}

// MARK: - UICollectionView Delegate

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = collectionView.tag
        switch section {                        // tag는 섹션(행) 번호를 의미
        case TVShowSections.recommand.rawValue: // 추천 섹션(1번행)일 경우
            return recommandList.count
        case TVShowSections.cast.rawValue:      // 캐스트 섹션(2번행)일 경우
            return castList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as? SeriesCollectionViewCell else { return UICollectionViewCell() }
        
        let section = collectionView.tag
        switch section {
        case TVShowSections.recommand.rawValue:
            cell.configureSeriesCell(recommandList[indexPath.item])
            return cell
        case TVShowSections.cast.rawValue:
            cell.configureCastCell(castList[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UITableView Delegate

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TVShowSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let targetSeries else { return UITableViewCell() }
        
        if indexPath.item == TVShowSections.details.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeriesDetailTableViewCell.identifier, for: indexPath) as? SeriesDetailTableViewCell else { return UITableViewCell() }
            cell.configureCell(targetSeries)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeriesTableViewCell.identifier, for: indexPath) as? SeriesTableViewCell else { return UITableViewCell() }
            
            // 컬렉션 뷰에 Tag 설정
            cell.cellCollectionView.tag = indexPath.row
            
            // 테이블 뷰 타이틀 설정
            cell.sectionTitle.text = TVShowSections(rawValue: indexPath.row)?.title
            
            // 컬렉션 뷰 delegate
            cell.cellCollectionView.dataSource = self
            cell.cellCollectionView.delegate = self
            cell.cellCollectionView.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
            
            // 컬렉션 뷰 reload
            cell.cellCollectionView.reloadData()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case TVShowSections.details.rawValue:
            return 380
        case TVShowSections.recommand.rawValue:
            return 280
        case TVShowSections.cast.rawValue:
            return 280
        default:
            return 0
        }
    }
}

// MARK: - UITableView Configuration Method

extension DetailViewController {
    func configureTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(SeriesDetailTableViewCell.self, forCellReuseIdentifier: SeriesDetailTableViewCell.identifier)
        detailTableView.register(SeriesTableViewCell.self, forCellReuseIdentifier: SeriesTableViewCell.identifier)
    }
}

// MARK: - UI Configuration Method

extension DetailViewController {
    func render() {
        view.addSubview(detailTableView)
        detailTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
