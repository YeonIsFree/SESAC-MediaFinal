//
//  SearchImage.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/09.
//

import Foundation

struct UnsplashModel: Decodable {
    let urls: UnsplashImage
}

struct UnsplashImage: Decodable {
    let regular: String
}
