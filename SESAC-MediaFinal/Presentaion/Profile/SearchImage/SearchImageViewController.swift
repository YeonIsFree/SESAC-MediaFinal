//
//  SerachImageViewController.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/09.
//

import UIKit

class SearchImageViewController: UIViewController {
    
    var imageURL: ((String) -> Void)?
    var imageURLString: String = ""
    
     // MARK: - UI Properties
    
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "이미지를 검색해주세요"
        return searchBar
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
     // MARK: - Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.searchImageView.clipsToBounds = true
            self.searchImageView.layer.cornerRadius = self.searchImageView.frame.height / 2
        }
        
        configureProfileImage()
        configureSearchBar()
        render()
    }
    
     // MARK: - Configure Image: 이전 화면에서 전달 받은 값
    
    private func configureProfileImage() {
        if let imageUrl = URL(string: imageURLString) {
            searchImageView.kf.setImage(with: imageUrl)
        } else { return }
    }
    
     // MARK: - UI Configuration Method
    
    private func render() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(80)
        }
        
        view.addSubview(searchImageView)
        searchImageView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.size.equalTo(250)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

 // MARK: - UISearchBar Delegate

extension SearchImageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        UnsplashManager.shared.fetchData(type: UnsplashModel.self, api: .search(query: text)) { images in
            
            self.imageURL?(images.urls.regular)
            
            if let imageUrl = URL(string: images.urls.regular) {
                self.searchImageView.kf.setImage(with: imageUrl)
            } else { return }
        }
        
        view.endEditing(true)
    }
}

extension SearchImageViewController {
    func configureSearchBar() {
        searchBar.delegate = self
    }
}
