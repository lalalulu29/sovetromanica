//
//  SearchAnimeModel.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 16.02.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import Foundation

struct SearchAnime: Decodable {
    var anime_description: String?
    var anime_episodes: Int?
    var anime_folder: String?
    var anime_id: Int?
    var anime_keywords: String?
    var anime_name: String?
    var anime_name_russian: String?
    var anime_studio: Int?
    var anime_year: Int?
    
    var code: Int?
    var description: String?
}
