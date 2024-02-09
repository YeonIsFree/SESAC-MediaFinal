//
//  APIModel.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/03.
//

import Foundation

struct TVSeriesModel: Decodable {
    let results: [TVSeries]
}

struct TVSeries: Decodable {
    let id: Int
    let backdrop_path: String?
    let poster_path: String?
    let name: String
    let overview: String
}

struct CastModel: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let profile_path: String?
}
