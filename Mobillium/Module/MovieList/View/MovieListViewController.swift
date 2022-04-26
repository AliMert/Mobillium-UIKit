//
//  MovieListViewController.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 25.04.2022.
//

import UIKit
import SnapKit

final class MovieListViewController: UIViewController {

    // MARK: - ViewModel

    private var viewModel: MovieListViewModelProtocol!

    // MARK: - Views

    private var topConstraint: NSLayoutConstraint?
    private let sliderView = SliderView()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight =  127
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: .main), forCellReuseIdentifier: "MovieListTableViewCell")
        tableView.separatorInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        return tableView
    }()

    // MARK: - Life Cyles

    convenience init(viewModel: MovieListViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        viewModel.loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barStyle = .black
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - UI

    private func prepareUI() {
        view.backgroundColor = .systemBackground
        setupTableView()
        sliderView.delegate = self
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        topConstraint = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        tableView.snp.makeConstraints { make in
            topConstraint?.isActive = true
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width)
        }

        tableView.tableHeaderView = sliderView
        sliderView.snp.makeConstraints({ make in
            make.width.equalTo(tableView.snp.width)
            make.height.equalTo(256)
        })
        sliderView.layoutIfNeeded()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func pullToRefresh(refreshControl: UIRefreshControl) {
        viewModel.loadData()
    }
}

// MARK: - MovieListViewModelProtocol Methods

extension MovieListViewController: MovieListViewModelDelegate {

    func handleViewModelOutput(_ output: MovieListViewModelOutput) {
        switch output {
        case .setState(let state):
            switch state {
            case .success:
                sliderView.setupView(movies: viewModel.nowPlayingMovies)
                tableView.reloadData()
                tableView.refreshControl?.endRefreshing()
            case .failure(let errorMessage):
                showAlert(errorMessage)
            }
        case .setLoading(let isLoading):
            view.setLoading(isLoading)
        }
    }
}

// MARK: - SliderViewDelegate Methods

extension MovieListViewController: SliderViewDelegate {

    func didSelect(index: Int) {
        viewModel.didSelectNowPlayingMovie(at: index)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource Methods

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.upcomingMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.upcomingMovies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectUpcomingMovie(at: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.refreshControl?.isHidden == false && scrollView.contentOffset.y < -30 {
            topConstraint?.constant = 30
        } else {
            self.topConstraint?.constant = .zero
        }
        self.tableView.layoutIfNeeded()
    }
}
