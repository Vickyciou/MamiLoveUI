//
//  CheckoutOptionsResponse.swift
//  MamiLoveUI
//
//  Created by Vickyciou on 2023/9/18.
//

import Foundation

// MARK: - CheckoutOptionsResponse
struct CheckoutOptionsResponse: Codable {
    let payments: Payments
    let shippings: Shippings
    let preOrder: PreOrder

}

// MARK: - Payments
struct Payments: Codable {
    let title: String
    let options: [PaymentsOption]
}

// MARK: - PaymentsOption
struct PaymentsOption: Codable {
    let title: String
    let icon: String
}

// MARK: - PreOrder
struct PreOrder: Codable {
    let title, description: String
}

// MARK: - Shippings
struct Shippings: Codable {
    let title: String
    let options: [ShippingsOption]
}

// MARK: - ShippingsOption
struct ShippingsOption: Codable {
    let isConvenienceStore: Bool
    let freeThreshold: Int
    let title: String
    let shippingFee: Int

}
