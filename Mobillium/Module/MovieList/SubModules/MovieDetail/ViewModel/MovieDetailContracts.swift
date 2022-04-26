//
//  MovieDetailContracts.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

protocol MovieDetailViewModelProtocol {
    var coordinatorDelegate: MovieCoordinatorProtocol? { get }
    var delegate: MovieDetailViewModelDelegate? { get set }
    var movieDetail: MovieDetailItem? { get }

    func loadData()
}

enum MovieDetailViewModelOutput: Equatable {
    case setState(State)
    case setLoading(Bool)
}

protocol MovieDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MovieDetailViewModelOutput)
}
