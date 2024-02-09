//
//  SeriesDetailTableViewCell.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/04.
//

import UIKit

class SeriesDetailTableViewCell: UITableViewCell {
    
     // MARK: - UI Properties
    
    let seriesBackgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let seriesTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let seriesOverview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
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

 // MARK: - Configuration Method

extension SeriesDetailTableViewCell {
    func configureCell(_ item: TVSeries) {
        guard let backdropImagePath = item.backdrop_path,
              let urlString = URL(string: TMDBEndpoint.baseImageURL + backdropImagePath) else { return }
        seriesBackgroundImageView.kf.setImage(with: urlString, placeholder: UIImage(systemName: "person"))
        seriesTitle.text = item.name
        let overview = (item.overview == "") ? "줄거리를 제공하지 않는 컨텐츠 입니다." : item.overview
        seriesOverview.text = overview
    }
}

 // MARK: - UI Configuration Method

extension SeriesDetailTableViewCell {
    func render() {
        contentView.addSubview(seriesBackgroundImageView)
        seriesBackgroundImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(210)
        }
        
        seriesBackgroundImageView.addSubview(seriesTitle)
        seriesTitle.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(seriesBackgroundImageView).inset(8)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(seriesOverview)
        seriesOverview.snp.makeConstraints { make in
            make.top.equalTo(seriesBackgroundImageView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
    }
}

