//
//  HomeTableViewCell.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/03.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {
    
     // MARK: - UI Properties
    
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    var cellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 10
        let cellWidth = (deviceWidth - spacing * 3 ) / 2.5
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configuration Method

extension SeriesTableViewCell {
   func render() {
       contentView.addSubview(sectionTitle)
       sectionTitle.snp.makeConstraints { make in
           make.top.equalTo(contentView)
           make.horizontalEdges.equalTo(contentView).inset(8)
           make.height.equalTo(22)
       }
       
       contentView.addSubview(cellCollectionView)
       cellCollectionView.snp.makeConstraints { make in
           make.top.equalTo(sectionTitle.snp.bottom)
           make.horizontalEdges.equalTo(contentView).inset(8)
           make.bottom.equalTo(contentView).inset(4)
       }
   }
}
