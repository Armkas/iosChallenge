//
//  ViewController.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/27.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var inputTestField: UITextField!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        fromButton.setTitle("USD", for: .normal)
        fromButton.setTitle("JPY", for: .normal)
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
    }

}

//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.currencyListCell, for: indexPath) else { return UITableViewCell() }
////        let rate = currencyData?.quotes[indexPath.row] ?? Rate.init(source: "XXX", target: "XXX", value: 0.0)
////        cell.bind(rate: rate)
////        return cell
////    }
//}
// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}
