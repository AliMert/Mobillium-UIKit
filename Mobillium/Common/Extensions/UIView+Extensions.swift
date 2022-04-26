//
//  UIView+Extensions.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 27.04.2022.
//

import UIKit.UIView
import SnapKit

extension UIView {

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            let loadingView = LoadingView()
            addSubview(loadingView)
            loadingView.snp.makeConstraints { make in
                make.top.bottom.leading.trailing.equalTo(self)
            }
        } else {
            viewWithTag(LoadingView.tag)?.removeFromSuperview()
        }
    }
}
