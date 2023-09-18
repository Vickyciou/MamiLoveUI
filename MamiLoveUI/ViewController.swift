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
    private let manager = CheckoutManager()
    private var checkoutOptions: CheckoutOptionsResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        view.backgroundColor = .white
        manager.delegate = self
        manager.getCheckoutOptionsResponse()
    }

    func setupNavigation() {
        // 設置背景顏色
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: navigationController?.navigationBar.frame.height ?? 0))
        backgroundView.backgroundColor = UIColor.systemPink // 設置為粉紅色
        navigationController?.navigationBar.insertSubview(backgroundView, at: 0)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()


        self.navigationBarBackgroundView = backgroundView
    }

    func setupTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 100
            let offsetY = scrollView.contentOffset.y

            var alphaComponent: CGFloat = 1.0

            if offsetY > 0 && offsetY <= navigationBarHeight {
                alphaComponent = 1 - (0.5 * offsetY / navigationBarHeight)
            } else if offsetY > navigationBarHeight {
                alphaComponent = 0.5
            }

            navigationBarBackgroundView?.alpha = alphaComponent
    }
}

extension ViewController: CheckoutManagerDelegate {
    func checkoutManager(_ manager: CheckoutManager, didGetCheckoutOptions checkoutOptions: CheckoutOptionsResponse) {
        self.checkoutOptions = checkoutOptions
        tableView.reloadData()
    }

    func checkoutManager(_ manager: CheckoutManager, didFailWith error: Error) {
        print("Did Fail With \(error)")
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

