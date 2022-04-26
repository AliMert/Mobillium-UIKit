//
//  MovieItem+Extensions.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

extension MovieItem {

    init(with item: Movie) {
        self.init(
            id: item.id,
            title: item.title,
            originalTitle: item.originalTitle,
            overview: item.overview,
            posterPath: item.posterPath,
            backdropPath: item.backdropPath,
            releaseDate: item.releaseDate?.customDateFormatter()
        )
    }
}
