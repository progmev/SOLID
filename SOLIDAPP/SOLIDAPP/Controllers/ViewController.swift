//
//  ViewController.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import UIKit

class ViewController: BaseViewController {
    
    // MARK: Properties

    let dataFetcherService: DataFetcherServiceProtocol = DataFetcherService()
    let dataStore = DataStoreSingletone.shared
    
    // MARK: - IBOutlets
    
    @IBOutlet var myTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        
        dataFetcherService.fetchCountry { countries in
            print("\n- - - fetchCountry: ")
            print(countries?.first?.Name ?? "", "\n")
        }

        dataFetcherService.fetchFreeGames { freeGames in
            print("\n- - - freeGames first: ")
            print(freeGames?.feed.results.first?.name ?? "", "\n")
        }

        dataFetcherService.fetchPaidGames { paidGames in
            print("\n- - - PaidGames first: ")
            print(paidGames?.feed.results.first?.name ?? "", "\n")
        }
        
        /*
         Added fetchLocalCountry
         */
        
        dataFetcherService.fetchLocalCountry { (localCountries) in
            print("\n- - - fetchLocalCountry last: ")
            print(localCountries?.last?.Name ?? "", "\n")
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
