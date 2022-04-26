//
//  MovieListNowPlayingResponse.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

struct MovieListNowPlayingResponse: Decodable {
    let results: [Movie]?
}

struct Movie: Decodable {
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case overview
    }
}
