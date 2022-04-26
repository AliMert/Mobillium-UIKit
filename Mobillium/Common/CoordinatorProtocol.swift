//
//  CoordinatorProtocol.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

protocol CoordinatorProtocol: AnyObject {
    var parentCoordinator: CoordinatorProtocol? { get }
    func start()
}
