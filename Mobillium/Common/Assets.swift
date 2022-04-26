//
//  Assets.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import UIKit.UIImage

enum Assets {
    case imdb
    case star

    var image: UIImage? {
        switch self {
        case .imdb:
            return UIImage(named: "IMDB Logo")
        case .star:
            return UIImage(named: "Rate Icon")
        }
    }
}
