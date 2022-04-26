//
//  MovieDetailItem+Extensions.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

extension MovieDetailItem {

    init(with item: MovieDetailResponse) {
        self.init(
            id: item.id,
            title: item.title,
            originalTitle: item.originalTitle,
            overview: item.overview,
            posterPath: item.posterPath,
            backdropPath: item.backdropPath,
            voteAverage: item.voteAverage,
            releaseDate: item.releaseDate?.customDateFormatter()
        )
    }
}
