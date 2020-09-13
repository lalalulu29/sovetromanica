//
//  LastSeriesStruct.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 10.08.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import Foundation

struct lastSeries: Decodable {
    let embed: String
    let episode_anime: Int
    let episode_count: Int
    let episode_id: Int
    let episode_type: Int
    let episode_updated_at: String
    let episode_view: Int
}


struct additionalInfoForAnime: Decodable {
    let anime_name_russian: String
    let anime_folder: String
}
