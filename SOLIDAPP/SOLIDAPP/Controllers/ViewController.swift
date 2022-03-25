//
//  ViewController.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import UIKit

class ViewController: UIViewController {
    
    let urlString = "https://raw.githubusercontent.com/Softex-Group/task-mobile/master/test.json"
    
    // MARK: - IBOutlets
    
    @IBOutlet var myTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        dataFetcher(pathURLString: urlString)
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
    
    // MARK: - NetworkService
    
    private func dataFetcher(pathURLString: String) {
        request(urlString: urlString) { [weak self] data, _ in
            let decoder = JSONDecoder()
            guard let data = data else {
                return
            }
            let response = try? decoder.decode([Country].self, from: data)
            print(response ?? "")
    
            // пример когда может возникнуть memory leak в замыкании
            self?.textLabel.text = response?[0].Name
        }
    }
    
    private func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        } // .resume()
        task.resume()
    }

    // MARK: - DataStore
    
    private func saveName(name: String) {
        print("Your name: \(name) is saved")
    }
    
    private func getName() -> String {
        "some name"
    }
    
    private func saveName() {
        if let email = myTextField.text, isValidEmail(email) {
            saveName(name: email)
        } else {
            let alert = UIAlertController(title: "Error", message: "Bad email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - ValidateService

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct Country: Decodable {
    var Id: String
    var Time: String
    var Name: String
    var Image: String?
}
