//
//  SliderCollectionViewCell.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 25.04.2022.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
