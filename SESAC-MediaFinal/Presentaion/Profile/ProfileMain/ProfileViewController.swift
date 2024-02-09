//
//  ProfileViewController.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/08.
//

import UIKit

enum Sections: Int, CaseIterable {
    case image
    case name
    case nickname
    case aboutMe
    
    var title: String {
        switch self {
        case .image:
            return ""
        case .name:
            return "이름"
        case .nickname:
            return "닉네임"
        case .aboutMe:
            return "소개"
        }
    }
}

final class ProfileViewController: UIViewController {
    
    var userData: [Int : String] = [
        1 : "천세련",
        2 : "Yeon",
        3 : "안녕하세요!"
    ] {
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
    
    // MARK: - UI Configuration Method
    
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

// MARK: - UITableView Delegate

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 이미지 뷰 셀
        if indexPath.row ==  Sections.image.rawValue {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileImageTableViewCell.identifier,
                for: indexPath) as? ProfileImageTableViewCell else { return UITableViewCell() }
            return cell
            
            // 유저 데이터 셀
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileTableViewCell.identifier,
                for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            
            guard let cellType = Sections(rawValue: indexPath.row) else { return UITableViewCell()}
            
            // cell 타이틀 설정
            cell.configureCellTitle(cellType.title)
            
            // 각 행의 textField에 tag 설정
            cell.textField.tag = indexPath.row
            
            //
            cell.textField.text = userData[indexPath.row]!
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == Sections.image.rawValue {
            // 이미지 셀 눌렀을 경우 ----> TO BE CONTINUED
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
        if indexPath.row == Sections.image.rawValue {
            return 220
        } else {
            return 60
        }
    }
}

extension ProfileViewController {
    private func configureTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        profileTableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: ProfileImageTableViewCell.identifier)
    }
}

