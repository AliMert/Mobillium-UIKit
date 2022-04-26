//
//  UIViewController+Extensions.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 27.04.2022.
//

import UIKit.UIViewController

extension UIViewController {

    func showAlert(_ message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
