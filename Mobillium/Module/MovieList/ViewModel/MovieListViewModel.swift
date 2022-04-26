//
//  MovieListViewModel.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import Foundation

final class MovieListViewModel: MovieListViewModelProtocol {
    weak var coordinatorDelegate: MovieCoordinatorProtocol?
    weak var delegate: MovieListViewModelDelegate?
    private(set) var nowPlayingMovies: [Movie] = []
    private(set) var upcomingMovies: [Movie] = []

    private var serviceCallGroup = DispatchGroup()

    func loadData() {
        callNowPlaying()
        callUpcoming()

        serviceCallGroup.notify(queue: .main) { [weak self] in
            self?.delegate?.handleViewModelOutput(.setState(.success))
        }
    }
}

// MARK: - Network

private extension MovieListViewModel {

    func callNowPlaying() {
        serviceCallGroup.enter()
        MovieListService.nowPlaying { [weak self] (response) in
            guard let self = self else {
                return
            }

            switch response.result {
            case .success(let response):
                if let movies = response.results {
                    self.nowPlayingMovies = Array(movies.prefix(5))
                }
            case .failure(let error):
                print(error)
            }
            self.serviceCallGroup.leave()
        }
    }

    func callUpcoming() {
        serviceCallGroup.enter()
        MovieListService.upcoming { [weak self] (response) in
            guard let self = self else {
                return
            }

            switch response.result {
            case .success(let response):
                self.upcomingMovies = response.results ?? []
            case .failure(let error):
                print(error)
            }
            self.serviceCallGroup.leave()
        }
    }
}
