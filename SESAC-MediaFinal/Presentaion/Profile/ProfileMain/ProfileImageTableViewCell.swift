//
//  ProfileImageTableViewCell.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/08.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .systemYellow
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    private func render() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(contentView.safeAreaLayoutGuide)
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(50)
        }
    }
}

