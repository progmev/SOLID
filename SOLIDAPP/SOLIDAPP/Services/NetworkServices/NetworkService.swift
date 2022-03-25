//
//  NetworkService.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import Foundation

// MARK: - Networking

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {

    // MARK: Internal

    // Что бы закрыь метод для модификации используем протокол Networking
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    // MARK: Private

    func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: requst, completionHandler: { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
