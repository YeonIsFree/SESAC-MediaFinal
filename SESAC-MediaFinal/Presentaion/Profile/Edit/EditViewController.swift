//
//  EditViewController.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/08.
//

import UIKit

class EditViewController: UIViewController {
    
    var userData: [Int : String] = [:]
    var indexPathRow: Int = 0
    var editedUserData: (([Int : String]) -> Void)?
    
     // MARK: - UI Property
    
    lazy var textField: UITextField = {
        let textField = UITextField()
//        textField.placeholder = "수정하실 \(Sections(rawValue: indexPathRow)!)을(를) 입력해주세요"
        textField.tintColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    
     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTextField()
        render()

    }
    
     // MARK: - TextField Configuration
    
    private func configureTextField() {
        // 화면 이동 시 넘어온 유저 데이터를 이용하여 텍스트필드 채워놓기
        textField.text = userData[indexPathRow]
    }
    
     // MARK: - Button Action Method
    
    @objc
    private func saveButtonTapped() {
        userData[indexPathRow] = textField.text!
        editedUserData?(userData)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UI Configuration Method
   
   private func configureNavigation() {
       navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), 
                                                           style: .done, target: self,
                                                           action: #selector(saveButtonTapped))
       
       guard let cellType = Sections(rawValue: indexPathRow) else { return }
       
       navigationItem.title = "\(cellType.title) 수정"
   }
    
    private func render() {
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
    }
}
