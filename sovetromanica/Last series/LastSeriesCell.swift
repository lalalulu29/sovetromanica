//
//  LastSeriesCell.swift
//  sovetromanica
//
//  Created by Кирилл Любарских  on 10.08.2020.
//  Copyright © 2020 Кирилл Любарских. All rights reserved.
//

import UIKit

class LastSeriesCell: UITableViewCell {

    @IBOutlet weak var imageSeries: UIImageView!
    @IBOutlet weak var animeName: UILabel!
    @IBOutlet weak var animeNumber: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var dubOrSub: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
