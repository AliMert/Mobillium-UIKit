//
//  String+Extensions.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import Foundation.NSDateFormatter

extension String {

    func customDateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: self) else {
            return self
        }

        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
