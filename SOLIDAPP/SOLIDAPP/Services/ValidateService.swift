//
//  ValidateService.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import Foundation

final class ValidateService {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
