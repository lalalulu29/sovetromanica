//
//  AnimeSeriesModel.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 06.03.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import Foundation


struct animeSeriesStruct: Decodable {
    let embed: String?
    let episode_anime: Int?
    let episode_count: Int?
    let episode_id: Int?
    let episode_type: Int?
    let episode_view: Int?
}


struct favariteAnimeCoreDate {
    let anime_description: String?
    let anime_episodes: Int?
    let anime_folder: String!
    let anime_id: Int!
    let anime_keywords: String?
    let anime_name: String!
    let anime_name_russian: String!
    let anime_studio: Int?
    let anime_year: Int?
    
    let image: Data?
}
