//
//  MovieDetailViewModel.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    weak var coordinatorDelegate: MovieCoordinatorProtocol?
    weak var delegate: MovieDetailViewModelDelegate?

    func loadData() {
    }
}
