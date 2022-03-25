//
//  ViewController.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import UIKit

class ViewController: BaseViewController {
    
    // MARK: Properties

    let networkService = NetworkService.shared
    let dataStore = DataStore.shared
    
    // MARK: - IBOutlets
    
    @IBOutlet var myTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        networkService.dataFetcher(urlString: Constans.urlString) { data, error in
            print(data)
        }
    }
    
    // MARK: - IBActions

    @IBAction func changeLabel(_ sender: Any) {
        if let email = myTextField.text, email.isEmpty {
            textLabel.text = "Please enter email"
            saveButton.isEnabled = false
        } else {
            textLabel.text = "Go!"
            saveButton.isEnabled = true
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        saveName()
    }
    
    private func saveName() {
        if let email = myTextField.text, ValidateService.isValidEmail(email) {
            dataStore.saveName(name: email)
        } else {
            showAlert(title: "Error", text: "Bad email")
        }
    }
}
