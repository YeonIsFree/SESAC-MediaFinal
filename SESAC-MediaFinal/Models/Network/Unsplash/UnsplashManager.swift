//
//  UnsplashManager.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/09.
//

import Foundation
import Alamofire

class UnsplashManager {
    
    static let shared = UnsplashManager()
    
    func fetchData<T: Decodable>(type: T.Type, api: UnsplashEndpoint, completionHandler: @escaping ((T) -> Void)) {
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: type) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("Network Fail", failure)
            }
        }
    }
}
