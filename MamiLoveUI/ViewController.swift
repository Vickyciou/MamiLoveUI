//
//  ViewController.swift
//  MamiLoveUI
//
//  Created by Vickyciou on 2023/9/18.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = makeTableView()
    private var navigationBarBackgroundView: UIView?
    private let provider = CheckoutDataProvider()
    private var checkoutOptions: CheckoutOptionsResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
        getCheckoutData()

    }

    func setupTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func getCheckoutData() {
        provider.getCheckoutOptionsResponse { result in
            switch result {
            case .success(let checkoutOptions):
                self.checkoutOptions = checkoutOptions
            case .failure(let error):
                switch error {
                case .decodingError(let error):
                    print("Decoding error: \(error)")
                case .fileNotFound:
                    print("Error: MockData.json file not found.")
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let checkoutOptions else { fatalError("There is no checkoutOptions.") }


        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as? PaymentCell else { fatalError("Cannot created PaymentCell") }
            let payment = checkoutOptions.payments
            let paymentSubtitle = payment.options.map { $0.title }.joined(separator: "・")
            cell.setupPaymentCell(title: payment.title, subtitle: paymentSubtitle)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingCell", for: indexPath) as? ShippingCell else { fatalError("Cannot created ShippingCell") }
            let shippings = checkoutOptions.shippings
            let shippingOptions = shippings.options.map{ $0.title }
            let freeThreshold = shippings.options.map{ $0.freeThreshold }
            cell.setupShippingCell(title: shippings.title, topShippingOption: shippingOptions[0], topFreeThreshold: "滿$\(freeThreshold[0])免運", bottomShippingOption: shippingOptions[1], bottomFreeThreshold: "滿$\(freeThreshold[1])免運")
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PreOrderCell", for: indexPath) as? PreOrderCell else { fatalError("Cannot created PreOrderCell") }
            let preOrder = checkoutOptions.preOrder
            cell.setupPreOrderCell(title: preOrder.title, subtitle: preOrder.description)
            return cell
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = "\(indexPath.row + 1)"
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y + view.safeAreaInsets.top
        if #available(iOS 13.0, *) {
            let percentage = min(1, yOffset / view.safeAreaInsets.top)
            let newAlpha = 1 - percentage
            let newColor = UIColor.red.withAlphaComponent(newAlpha)

            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = newColor

            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.standardAppearance = appearance
        } else {
            // iOS 12.0 的作法
        }
    }
}

extension ViewController {
    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PaymentCell.self, forCellReuseIdentifier: "PaymentCell")
        tableView.register(ShippingCell.self, forCellReuseIdentifier: "ShippingCell")
        tableView.register(PreOrderCell.self, forCellReuseIdentifier: "PreOrderCell")
        tableView.allowsSelection = false
        return tableView
    }
}

