//
//  MovieDetailViewController.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - ViewModel

    private var viewModel: MovieDetailViewModelProtocol!

    // MARK: - Views

    private var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private var scrollView = UIScrollView()

    // MARK: - Life Cyles

    convenience init(viewModel: MovieDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }


    // MARK: - UI

    private func prepareUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        scrollView.backgroundColor = .red
        contentStack.backgroundColor = .yellow
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        contentStack.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
        }
    }

}

// MARK: - MovieDetailViewModelProtocol Methods

extension MovieDetailViewController: MovieDetailViewModelDelegate {

    func handleViewModelOutput(_ output: MovieDetailViewModelOutput) {

    }
}

