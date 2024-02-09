//
//  ProfileTableViewCell.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/08.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        return textField
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Methods
    
    func configureCellTitle(_ title: String) {
        titleLabel.text = title
    }
    
    private func render() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(titleLabel.snp.trailing).inset(10)
            make.height.equalTo(50)
        }
    }
}
