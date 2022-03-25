//
//  DataFetcherService.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import Foundation

protocol DataFetcherServiceProtocol {
    func fetchNewGames(completion: @escaping (AppGroup?) -> Void)
    func fetchFreeGames(completion: @escaping (AppGroup?) -> Void)
    func fetchCountry(completion: @escaping ([Country]?) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    
    var dataFetcher: DataFetcher
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }

    func fetchNewGames(completion: @escaping (AppGroup?) -> Void) {
        dataFetcher.fetchGenericJSONData(urlString: Constants.urlPaidGames, response: completion)
    }

    func fetchFreeGames(completion: @escaping (AppGroup?) -> Void) {
        dataFetcher.fetchGenericJSONData(urlString: Constants.urlFreeGames, response: completion)
    }

    func fetchCountry(completion: @escaping ([Country]?) -> Void) {
        dataFetcher.fetchGenericJSONData(urlString: Constants.urlString, response: completion)
    }

    // @escaping - сбегабщее выражение (замыкание сбегает из области видимости ф-ции fetch...), необходимо для того что бы в конце выполнения ф-ции, блок задержался в памяти до того момента пока не прийдет ответ от сервера.
    // Показываем что замыкание будет вызвано после выполнения ф-ции. Такие ф-ции часто используются в асинхронных операциях
}
