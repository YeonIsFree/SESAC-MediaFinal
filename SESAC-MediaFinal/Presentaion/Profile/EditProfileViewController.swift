//
//  EditProfileViewController.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/08.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var myProfile = UserProfile(name: "", nickname: "", aboutMe: "")
    var profile: ((UserProfile) -> Void)?
    
    // MARK: - UI Properties
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .darkGray
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "수정할 이름을 입력해주세요"
        return textField
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "수정할 닉네임을 입력해주세요"
        return textField
    }()
    
    let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = "소개"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let aboutMeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "소개소개소개"
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitle()
        configrureSaveButton()
        render()
    }
    
     // MARK: - Button Action Method
    
    func configrureSaveButton() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func saveButtonTapped() {
        myProfile.name = nameTextField.text!
        myProfile.nickname = nicknameTextField.text!
        myProfile.aboutMe = aboutMeTextField.text!
        
        profile?(myProfile)
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - UI Configuration Method
    
    func configureNavigationTitle() {
        navigationItem.title = "프로필 수정"
    }
    
    func render() {
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
            make.leading.equalTo(nameLabel.snp.trailing)
            make.height.equalTo(50)
        }
        
        view.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.trailing)
            make.height.equalTo(50)
        }
        
        view.addSubview(aboutMeLabel)
        aboutMeLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        view.addSubview(aboutMeTextField)
        aboutMeTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.leading.equalTo(aboutMeLabel.snp.trailing)
            make.height.equalTo(50)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(50)
        }
    }
}
