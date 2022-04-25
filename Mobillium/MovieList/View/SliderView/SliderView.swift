//
//  SliderView.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 25.04.2022.
//

import UIKit

final class SliderView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    init(height: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        loadXib()
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: "SliderCollectionViewCell")
        collectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func loadXib() {
        guard let viewFromXib = Bundle.main.loadNibNamed("SliderView", owner: self, options: nil)?[0] as? UIView else {
            return
        }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }

}

extension SliderView:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 3
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as? SliderCollectionViewCell else {
            return UICollectionViewCell()
        }

        switch indexPath.row {
        case 0:
            cell.backgroundColor = .red.withAlphaComponent(0.4)
        case 1:
            cell.backgroundColor = .blue.withAlphaComponent(0.4)
        default:
            cell.backgroundColor = .yellow.withAlphaComponent(0.4)
        }
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
