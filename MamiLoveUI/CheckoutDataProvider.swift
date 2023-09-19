//
//  CheckoutManager.swift
//  MamiLoveUI
//
//  Created by Vickyciou on 2023/9/18.
//

import Foundation

enum CheckoutDataProviderError: Error {
    case fileNotFound
    case decodingError(Error)
}

class CheckoutDataProvider {

    func getCheckoutOptionsResponse(completionHandler: @escaping (Result<CheckoutOptionsResponse, CheckoutDataProviderError>) -> Void) {
        if let url = Bundle.main.url(forResource: "MockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let checkoutOptions = try decoder.decode(CheckoutOptionsResponse.self, from: data)
                completionHandler(.success(checkoutOptions))
            } catch {
                completionHandler(.failure(.decodingError(error)))
            }
        } else {
            completionHandler(.failure(.fileNotFound))
        }
    }
}
