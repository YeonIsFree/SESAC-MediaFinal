//
//  Profile.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/09.
//

import Foundation

enum ProfileSections: Int, CaseIterable {
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
