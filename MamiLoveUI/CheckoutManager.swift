//
//  CheckoutManager.swift
//  MamiLoveUI
//
//  Created by Vickyciou on 2023/9/18.
//

import Foundation

protocol CheckoutManagerDelegate: AnyObject {
    func checkoutManager(_ manager: CheckoutManager, didGetCheckoutOptions checkoutOptions: CheckoutOptionsResponse)
    func checkoutManager(_ manager: CheckoutManager, didFailWith error: Error)
}

class CheckoutManager {
    weak var delegate: CheckoutManagerDelegate?

    func getCheckoutOptionsResponse() {
        if let url = Bundle.main.url(forResource: "MockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let checkoutOptions = try decoder.decode(CheckoutOptionsResponse.self, from: data)
                delegate?.checkoutManager(self, didGetCheckoutOptions: checkoutOptions)
            } catch {
                delegate?.checkoutManager(self, didFailWith: error)
            }
        }
    }
}
