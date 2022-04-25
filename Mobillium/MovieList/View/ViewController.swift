//
//  MovieListViewController.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 25.04.2022.
//

import UIKit

final class MovieListViewController: UIViewController {
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.tableHeaderView = SliderView(height: tableView.sectionHeaderHeight)
        tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: .main), forCellReuseIdentifier: "MovieListTableViewCell")

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc private func pullToRefresh(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped at: ", indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.refreshControl?.isHidden == false {
            topConstraint.constant = 30
        } else {
            self.topConstraint.constant = .zero
        }
        self.tableView.layoutIfNeeded()
    }
}
