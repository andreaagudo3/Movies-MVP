//
//  MovieCell.swift
//  Movies
//
//  Created by Andrea Agudo on 23/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import UIKit

class MovieCellView: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
