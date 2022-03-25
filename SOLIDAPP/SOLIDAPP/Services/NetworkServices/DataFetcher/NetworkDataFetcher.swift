//
//  NetworkDataFetcher.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import Foundation

// MARK: - DataFetcher

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void)
}

// MARK: - NetworkDataFetcher

/*
 Этот класс с использовнием Networking вытаскивает данные из сети и пытается их распарсить
 */

/*
 NetworkDataFetcher - Модуль нижнего уровня для DataFetcherService
 NetworkDataFetcher - Модуль высшего  уровня для NetworkService
 */

class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    // MARK: Lifecycle

    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }

    // MARK: Internal

    // Когда будем вызывать, ф-я будет требовать возвращать обьект подписанный под Decodable
    // Что бы закрыь метод для модификации используем протоколы
    // Пробуем теперь удалить ф-ю / изменить параметры)
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void) {
        print("fetchGenericJSONData: T.self: \(T.self)")
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, data: data)
            response(decoded)
        }
    }

    // MARK: Private

    // Декодирование Data в любую модель
    func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
