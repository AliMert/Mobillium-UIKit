//
//  MovieDetailViewModel.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    weak var coordinatorDelegate: MovieCoordinatorProtocol?
    weak var delegate: MovieDetailViewModelDelegate?
    private(set) var movieDetail: MovieDetailItem?

    private let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }

    func loadData() {
        callMovieDetail()
    }
}

// MARK: - Network

private extension MovieDetailViewModel {

    func callMovieDetail() {
        delegate?.handleViewModelOutput(.setLoading(true))
        MovieService.detail(with: movieId) { [weak self] (response) in
            guard let self = self else {
                return
            }
            self.delegate?.handleViewModelOutput(.setLoading(false))

            switch response.result {
            case .success(let response):
                self.movieDetail = MovieDetailItem(with: response)
                self.delegate?.handleViewModelOutput(.setState(.success))
            case .failure(let error):
                self.delegate?.handleViewModelOutput(.setState(.failure(error.localizedDescription)))
            }
        }
    }
}
