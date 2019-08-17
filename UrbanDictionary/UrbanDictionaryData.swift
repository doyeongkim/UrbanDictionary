//
//  UrbanDictionaryData.swift
//  UrbanDictionary
//
//  Created by Solji Kim on 16/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import Foundation

// MARK: - UrbanDictionaryData
struct UrbanDictionaryData: Codable {
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let definition: String
    let permalink: String
    let thumbsUp: Int
    let soundUrls: [String]
    let author, word: String
    let defid: Int
    let currentVote, writtenOn, example: String
    let thumbsDown: Int
    
    enum CodingKeys: String, CodingKey {
        case definition, permalink
        case thumbsUp = "thumbs_up"
        case soundUrls = "sound_urls"
        case author, word, defid
        case currentVote = "current_vote"
        case writtenOn = "written_on"
        case example
        case thumbsDown = "thumbs_down"
    }
}
