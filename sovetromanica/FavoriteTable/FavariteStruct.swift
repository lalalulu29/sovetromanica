//
//  FavariteStruct.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 09.03.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import Foundation

struct favaruteAnime: Decodable {
    let anime_description: String?
    let anime_episodes: Int?
    let anime_folder: String!
    let anime_id: Int!
    let anime_keywords: String?
    let anime_name: String!
    let anime_name_russian: String!
    let anime_studio: Int?
    let anime_year: Int?
    
    
    
    let code: Int?
    let description: String?
}
