//
//  MovieDetailResponse.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

struct MovieDetailResponse: Decodable {
    let id: Int?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Float?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case title
        case overview
        case id
    }
}
