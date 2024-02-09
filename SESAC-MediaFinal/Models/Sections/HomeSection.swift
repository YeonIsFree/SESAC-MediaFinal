//
//  Home.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/03.
//

import Foundation

enum HomeSections: Int, CaseIterable {
    case trend = 0
    case topRated = 1
    case popular = 2
    
    var title: String {
        switch self {
        case .trend:
            return "Trend"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        }
    }
}
