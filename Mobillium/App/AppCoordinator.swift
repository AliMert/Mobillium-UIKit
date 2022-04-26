//
//  AppCoordinator.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    private(set) var rootViewController: UINavigationController!
    private var children: [CoordinatorProtocol] = []
    var parentCoordinator: CoordinatorProtocol?

    func start() {
        let coordinator = MovieCoordinator()
        coordinator.start()
        children.append(coordinator)
        coordinator.parentCoordinator = self
        rootViewController = coordinator.rootViewController
    }
}
