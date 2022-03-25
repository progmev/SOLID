//
//  NetworkService.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import Foundation

final class NetworkService {

    static let shared = NetworkService()
    private init() { }

    public func dataFetcher(urlString: String, completion: @escaping ([Country]?, Error?) -> Void) {
        request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode([Country].self, from: data)
            print(response ?? "")
            completion(response, error)
        }
    }

    private func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
}
