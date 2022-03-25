//
//  BaseViewController.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import UIKit

class BaseViewController: UIViewController {
    func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
