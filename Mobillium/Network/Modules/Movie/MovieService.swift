//
//  MovieListService.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import Alamofire

final class MovieService {

    static func nowPlaying(completion: @escaping (Response<MovieListNowPlayingResponse>)->Void) {
        NetworkManager.request(
            Endpoint.Movie.List.nowPlaying,
            MovieListNowPlayingResponse.self,
            completion: completion
        )
    }

    static func upcoming(completion: @escaping (Response<MovieListUpcomingResponse>)->Void) {
        NetworkManager.request(
            Endpoint.Movie.List.upcoming,
            MovieListUpcomingResponse.self,
            completion: completion
        )
    }

    static func detail(with movieId: Int, completion: @escaping (Response<MovieDetailResponse>)->Void) {
        NetworkManager.request(
            Endpoint.Movie.detail(id: movieId),
            MovieDetailResponse.self,
            completion: completion
        )
    }
}
