//
//  LoadingView.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import UIKit
import SnapKit

final class LoadingView: UIView {

    static let tag = 8274047
    private var spinner = UIActivityIndicatorView(style: .large)

    // MARK: - Init

    convenience init() {
        self.init(frame: .zero)
        prepareUI()
    }

    // MARK: - UI

    private func prepareUI() {
        backgroundColor = .black
        alpha = 0.6
        tag = LoadingView.tag

        spinner.startAnimating()
        spinner.color = .gray

        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}
