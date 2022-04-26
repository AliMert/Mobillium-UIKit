//
//  SliderCollectionViewCell.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 25.04.2022.
//

import UIKit
import AlamofireImage

final class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.backgroundColor = .black
        shadowView.alpha = 0.4
    }

    public func configure(with movie: MovieItem) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview

        guard let posterPath = movie.backdropPath,
              let url = URL(string: Endpoint.image + posterPath) else {
            return
        }
        imageView.af.setImage(withURL: url, placeholderImage: UIImage())
    }
}
