//
//  Endpoint.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import Foundation
enum Endpoint {
    static let image = "https://image.tmdb.org/t/p/w500/"
    static let base = "https://api.themoviedb.org/3/"

    enum Movie{
        private static let movie = base + "movie/"

        enum List {
            static let nowPlaying = movie + "now_playing"
            static let upcoming = movie + "upcoming"
        }

        static func detail(id: Int) -> String {
            movie + "\(id)"
        }
    }
}
