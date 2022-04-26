//
//  MovieCoordinator.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import UIKit

protocol MovieCoordinatorProtocol: CoordinatorProtocol {
    func goToMovieDetail()
}

final class MovieCoordinator: MovieCoordinatorProtocol {
    private(set) var rootViewController = UINavigationController()
    var parentCoordinator: CoordinatorProtocol?

    func start() {
        let viewModel = MovieListViewModel()
        viewModel.coordinatorDelegate = self
        let controller = MovieListViewController(viewModel: viewModel)
        rootViewController = UINavigationController(rootViewController: controller)
    }

    func goToMovieDetail() {
        let viewModel = MovieDetailViewModel()
        viewModel.coordinatorDelegate = self
        let controller = MovieDetailViewController(viewModel: viewModel)
        rootViewController.pushViewController(controller, animated: true)
    }
}
