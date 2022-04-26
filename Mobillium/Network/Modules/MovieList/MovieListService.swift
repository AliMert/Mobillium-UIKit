//
//  MovieListService.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import Alamofire

final class MovieListService {

    static func nowPlaying(completion: @escaping (Response<MovieListNowPlayingResponse>)->Void) {
        NetworkManager.request(
            Endpoint.MovieList.nowPlaying,
            MovieListNowPlayingResponse.self,
            completion: completion
        )
    }

    static func upcoming(completion: @escaping (Response<MovieListUpcomingResponse>)->Void) {
        NetworkManager.request(
            Endpoint.MovieList.upcoming,
            MovieListUpcomingResponse.self,
            completion: completion
        )
    }
}
