//
//  SearchTableViewCell.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 15.02.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imageAnime: UIImageView!
    @IBOutlet weak var RuNameAnimeTextLabel: UITextView!
    @IBOutlet weak var EnNameAnimeTextLabel: UITextView!
    @IBOutlet weak var AgeAnimeTextLabel: UITextView!
    @IBOutlet weak var ProgresLoadingImages: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
