//
//  MovieListContracts.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

protocol MovieListViewModelProtocol {
    var coordinatorDelegate: MovieCoordinatorProtocol? { get }
    var delegate: MovieListViewModelDelegate? { get set }
    var nowPlayingMovies: [Movie] { get }
    var upcomingMovies: [Movie] { get }

    func loadData()
}

enum MovieListViewModelOutput: Equatable {
    case setState(State)
}

protocol MovieListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MovieListViewModelOutput)
}
