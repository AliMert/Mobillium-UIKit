//
//  SliderView.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 25.04.2022.
//

import UIKit

protocol SliderViewDelegate {
    func setupView(movies: [Movie])
}

final class SliderView: UIView {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    private var movies: [Movie] = []

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        loadXib()
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
    }

    private func loadXib() {
        guard let viewFromXib = Bundle.main.loadNibNamed("SliderView", owner: self, options: nil)?[0] as? UIView else {
            return
        }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}

extension SliderView: SliderViewDelegate {

    func setupView(movies: [Movie]) {
        self.movies = movies
        collectionView.reloadData()
    }
}

extension SliderView:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = movies.count
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as? SliderCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: movies[indexPath.row])
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / frame.width
        pageControl.currentPage = Int(scrollPos)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
}
