//
//  DataFetcherService.swift
//  SOLIDAPP
//
//  Created by Martynov Evgeny on 25.03.22.
//

import Foundation

protocol DataFetcherServiceProtocol {
    func fetchPaidGames(completion: @escaping (AppGroup?) -> Void)
    func fetchFreeGames(completion: @escaping (AppGroup?) -> Void)
    func fetchCountry(completion: @escaping ([Country]?) -> Void)
    func fetchLocalCountry(completion: @escaping ([Country]?) -> Void)
}

final class DataFetcherService: DataFetcherServiceProtocol {
    
    /*
     переименовали в networkDataFetcher и добавили localDataFetcher
     */
    
    var networkDataFetcher: DataFetcher
    var localDataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher(),
         localDataFetcher: DataFetcher = LocalDataFetcher()) {
        self.networkDataFetcher = dataFetcher
        self.localDataFetcher = localDataFetcher
    }

    func fetchPaidGames(completion: @escaping (AppGroup?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: Constants.urlPaidGames, response: completion)
    }

    func fetchFreeGames(completion: @escaping (AppGroup?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: Constants.urlFreeGames, response: completion)
    }

    func fetchCountry(completion: @escaping ([Country]?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: Constants.urlString, response: completion)
    }
    
    /*
     Added fetchLocalCountry
     */
    
    func fetchLocalCountry(completion: @escaping ([Country]?) -> Void) {
        localDataFetcher.fetchGenericJSONData(urlString: Constants.localUrlString, response: completion)
    }

    // @escaping - сбегабщее выражение (замыкание сбегает из области видимости ф-ции fetch...), необходимо для того что бы в конце выполнения ф-ции, блок задержался в памяти до того момента пока не прийдет ответ от сервера.
    // Показываем что замыкание будет вызвано после выполнения ф-ции. Такие ф-ции часто используются в асинхронных операциях
}
