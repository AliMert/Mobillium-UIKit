//
//  MovieDetailContracts.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

protocol MovieDetailViewModelProtocol {
    var coordinatorDelegate: MovieCoordinatorProtocol? { get }
    var delegate: MovieDetailViewModelDelegate? { get set }

    func loadData()
}

enum MovieDetailViewModelOutput: Equatable {
}

protocol MovieDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MovieDetailViewModelOutput)
}
