//
//  HomeCollectionViewCell.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/03.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "TEST TEST"
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
