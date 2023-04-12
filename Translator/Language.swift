//
//  Language.swift
//  Translator
//
//  Created by Bilegt Davaa on 2023-04-12.
//

import Foundation


enum Language: String, CaseIterable {
    case arabic = "ar"
    case english = "en"
    case french = "fr"
    case spanish = "es"
    case punjabi = "pa"
    case romanian = "ro"
    case mongolian = "mn"
    case russian = "ru"
    case ukrainian = "uk"
    case japanese = "ja"
    case hindi = "hi"
    case greek = "el"
    case simplifiedChinese = "zh-Hans"

    var name: String {
        switch self {
        case .arabic:
            return "Arabic"
        case .english:
            return "English"
        case .french:
            return "French"
        case .spanish:
            return "Spanish"
        case .punjabi:
            return "Punjabi"
        case .romanian:
            return "Romanian"
        case .mongolian:
            return "Mongolian"
        case .russian:
            return "Russian"
        case .ukrainian:
            return "Ukrainian"
        case .japanese:
            return "Japanese"
        case .hindi:
            return "Hindi"
        case .greek:
            return "Greek"
        case .simplifiedChinese:
            return "Simplified Chinese"
        }
    }
    
    
    static var allLanguages: [Language] {
        return [.arabic, .english, .french, .spanish, .punjabi, .romanian, .mongolian, .russian, .ukrainian, .japanese, .hindi, .greek, .simplifiedChinese]
            // Add other languages here
        }
    
}
