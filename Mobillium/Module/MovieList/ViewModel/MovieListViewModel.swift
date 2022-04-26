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
    private(set) var nowPlayingMovies: [MovieItem] = []
    private(set) var upcomingMovies: [MovieItem] = []

    private var serviceCallGroup = DispatchGroup()

    func loadData() {
        delegate?.handleViewModelOutput(.setLoading(true))
        callNowPlaying()
        callUpcoming()

        serviceCallGroup.notify(queue: .main) { [weak self] in
            self?.delegate?.handleViewModelOutput(.setLoading(false))
            self?.delegate?.handleViewModelOutput(.setState(.success))
        }
    }

    func didSelectNowPlayingMovie(at index: Int) {
        guard let id = nowPlayingMovies[index].id else {
            return
        }
        coordinatorDelegate?.goToMovieDetail(with: id)
    }

    func didSelectUpcomingMovie(at index: Int) {
        guard let id = upcomingMovies[index].id else {
            return
        }
        coordinatorDelegate?.goToMovieDetail(with: id)
    }
}

// MARK: - Network

private extension MovieListViewModel {

    func callNowPlaying() {
        serviceCallGroup.enter()
        MovieService.nowPlaying { [weak self] (response) in
            guard let self = self else {
                return
            }

            switch response.result {
            case .success(let response):
                if let movies = response.results {
                    self.nowPlayingMovies = Array(movies.prefix(5)).map(MovieItem.init)
                }
            case .failure(let error):
                self.delegate?.handleViewModelOutput(.setLoading(false))
                self.delegate?.handleViewModelOutput(.setState(.failure(error.localizedDescription)))
            }
            self.serviceCallGroup.leave()
        }
    }

    func callUpcoming() {
        serviceCallGroup.enter()
        MovieService.upcoming { [weak self] (response) in
            guard let self = self else {
                return
            }

            switch response.result {
            case .success(let response):
                self.upcomingMovies = (response.results?.map(MovieItem.init)) ?? []
            case .failure(let error):
                self.delegate?.handleViewModelOutput(.setLoading(false))
                self.delegate?.handleViewModelOutput(.setState(.failure(error.localizedDescription)))
            }
            self.serviceCallGroup.leave()
        }
    }
}
