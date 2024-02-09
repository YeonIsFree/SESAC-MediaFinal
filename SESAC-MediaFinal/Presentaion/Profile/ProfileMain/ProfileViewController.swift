//
//  ProfileViewController.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/08.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    var userData: [Int : String] = [1 : "천세련",
                                    2 : "Yeon",
                                    3 : "안녕하세요!"] 
    {
        didSet {
            profileTableView.reloadData()
        }
    }
    
    var profileImageURLString: String = "" {
        didSet {
            profileTableView.reloadData()
        }
    }
    
    // MARK: - UI Property
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigation()
        render()
    }
}

// MARK: - UITableView Delegate

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1) 프로필 이미지 셀
        if indexPath.row ==  ProfileSections.image.rawValue {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileImageTableViewCell.identifier,
                for: indexPath) as? ProfileImageTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            // 현재 데이터로 다음 화면 이미지 세팅해두기
            if let imageURL = URL(string: profileImageURLString) {
                cell.profileImageView.kf.setImage(with: imageURL)
            }
            
            return cell
            
            // 2) 유저 데이터 셀
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileTableViewCell.identifier,
                for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            guard let cellType = ProfileSections(rawValue: indexPath.row) else { return UITableViewCell()}
            
            // cell 타이틀 설정
            cell.configureCellTitle(cellType.title)
            
            // 각 행의 textField에 tag 설정
            cell.textField.tag = indexPath.row
            
            // 다음 화면 텍스트필드 미리 채워 놓기
            if let dataString = userData[indexPath.row] {
                cell.textField.text = dataString
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 프로필 이미지 셀
        if indexPath.row == ProfileSections.image.rawValue {
            let vc = SearchImageViewController()
            
            // 수정 화면으로 현재 값 전달
            vc.imageURLString = profileImageURLString
            
            // 수정 화면에서 꺼내온 이미지
            vc.imageURL = { imageURL in
                self.profileImageURLString = imageURL
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
            // 유저 데이터 셀
        } else {
            let vc = EditViewController()
            
            // 다음 화면 구성 위한 indexPath 전달
            vc.indexPathRow = indexPath.row
            
            // 다음 화면에 현재 유저 데이터 전달
            vc.userData = userData
            
            // 수정 화면에서 꺼내온 "수정된 데이터"
            vc.editedUserData = { userData in
                self.userData = userData
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == ProfileSections.image.rawValue {
            return 260
        } else {
            return 60
        }
    }
}

// MARK: - UITableView Configuration Method

extension ProfileViewController {
    private func configureTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        profileTableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: ProfileImageTableViewCell.identifier)
    }
}

// MARK: - UI Configuration Method

extension ProfileViewController {
    private func configureNavigation() {
        navigationItem.title = "프로필"
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func render() {
        view.addSubview(profileTableView)
        profileTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
