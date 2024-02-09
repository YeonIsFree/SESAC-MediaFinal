//
//  Endpoint.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/09.
//

import Foundation
import Alamofire

enum UnsplashEndpoint {
    case search(query: String)
    
    var header: HTTPHeaders {
        return ["Authorization" : APIKey.unsplash]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var endpoint: URL {
        switch self {
        case .search(let query):
            return URL(string: "https://api.unsplash.com/photos/random?query=\(query)")!
        }
    }
}
