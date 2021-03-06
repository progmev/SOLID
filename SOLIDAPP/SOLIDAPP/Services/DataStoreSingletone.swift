//
//  DataStore.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import Foundation

final class DataStoreSingletone {

    static let shared = DataStoreSingletone()
    private init() { }

    public func saveName(name: String) {
        print("Your name: \(name) is saved")
    }

    public func getName() -> String {
        return "some name"
    }
}
