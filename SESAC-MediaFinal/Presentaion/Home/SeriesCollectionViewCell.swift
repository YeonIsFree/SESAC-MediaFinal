//
//  HomeCollectionViewCell.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/03.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

 // MARK: - Cell Configure Method

extension SeriesCollectionViewCell {
    func configureSeriesCell(_ item: TVSeries) {
        guard let imagePath = item.poster_path,
              let urlString = URL(string: TMDBEndpoint.baseImageURL + imagePath) else { return }
        cellImageView.kf.setImage(with: urlString)
        cellLabel.text = item.name
    }
    
    func configureCastCell(_ item: Cast) {
        guard let imagePath = item.profile_path,
              let urlString = URL(string: TMDBEndpoint.baseImageURL + imagePath) else { return }
        cellImageView.kf.setImage(with: urlString)
        cellLabel.text = item.name
    }
}

// MARK: - UI Configuration

extension SeriesCollectionViewCell {
    func render() {
        contentView.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
        }
        
        contentView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
}
