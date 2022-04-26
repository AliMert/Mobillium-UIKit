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

    private let scrollView = UIScrollView()

    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let detailStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    private let featureStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private let avarageVoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Life Cyles

    convenience init(viewModel: MovieDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        viewModel.loadData()
    }


    // MARK: - UI

    private func prepareUI() {
        setupView()

        contentStack.insertArrangedSubview(imageView, at: .zero)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.height.equalTo(256)
        }

        let container = UIView()
        container.addSubview(featureStack)
        featureStack.snp.makeConstraints { make in
            make.leading.equalTo(container)
            make.top.equalTo(container)
            make.bottom.equalTo(container)
        }
        detailStack.addArrangedSubview(container)
        detailStack.addArrangedSubview(titleLabel)
        detailStack.addArrangedSubview(descriptionLabel)


        featureStack.addArrangedSubview(UIImageView(image: Assets.imdb.image))
        featureStack.addArrangedSubview(UIImageView(image: Assets.star.image))
        featureStack.addArrangedSubview(getRatingsView())
        featureStack.addArrangedSubview(getDotView())
        featureStack.addArrangedSubview(dateLabel)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
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

        let detailContainerView = UIView()
        detailContainerView.addSubview(detailStack)
        detailStack.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        }
        contentStack.addArrangedSubview(detailContainerView)
    }

    private func configureUI() {
        guard let movieDetail = viewModel.movieDetail else {
            return
        }
        title = movieDetail.title
        titleLabel.text = movieDetail.title
        descriptionLabel.text = movieDetail.overview
        dateLabel.text = movieDetail.releaseDate

        if let voteAverage = movieDetail.voteAverage {
            avarageVoteLabel.text = String(format: "%.2f", voteAverage)
        }

        guard let posterPath = movieDetail.backdropPath,
              let url = URL(string: Endpoint.image + posterPath) else {
                  return
              }
        imageView.af.setImage(withURL: url, placeholderImage: UIImage())
    }

    private func getDotView() -> UIView {
        let label = UILabel()
        label.text = "⋅"
        label.font = .systemFont(ofSize: 11, weight: .black)
        label.textColor = Color.dotColor
        return label
    }

    private func getRatingsView() -> UIView {
        avarageVoteLabel.text = "-"
        let voteLabel = UILabel()
        voteLabel.textColor = .lightGray
        voteLabel.font = .systemFont(ofSize: 13, weight: .medium)
        voteLabel.text = "/10"
        return UIStackView(arrangedSubviews: [avarageVoteLabel, voteLabel])
    }
}

// MARK: - MovieDetailViewModelProtocol Methods

extension MovieDetailViewController: MovieDetailViewModelDelegate {

    func handleViewModelOutput(_ output: MovieDetailViewModelOutput) {
        switch output {
        case .setState(let state):
            switch state {
            case .success:
                configureUI()
            case .failure(let errorMessage):
                print("something wnt wrong:", errorMessage)
            }
        case .setLoading(let isLoading):
            print("show loading:", isLoading)
        }
    }
}

