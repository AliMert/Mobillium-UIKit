//
//  SliderCollectionViewCell.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 25.04.2022.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        movieImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configure(with movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview

        guard let posterPath = movie.backdropPath,
              let url = URL(string: Endpoint.image + posterPath) else {
                  return
              }
        movieImageView.af.setImage(withURL: url, placeholderImage: UIImage())
    }
}
