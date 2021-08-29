//
//  ViewController.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var inputTestField: UITextField!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        resetUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Rates.timestamp == nil {
            getRatesAndSave()
        } else {
            checkTime()
        }
    }
    
    @IBAction func doConvert(_ sender: UIButton) {
        updateResult()
    }
    
    func resetUI() {
        inputTestField.text = "1.0"
        fromButton.setTitle("USD", for: .normal)
        toButton.setTitle("JPY", for: .normal)
        resultLabel.text = "-- Incorrect input value --"
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        tableView.reloadData()
    }
    
    func checkTime() {
        let now = Int(Date().timeIntervalSince1970)
        print("^^^", Rates.timestamp, now)
        if let timestamp = Rates.timestamp,
           now - timestamp > 1800000 { //30 min
            getRatesAndSave()
        }
    }
    
    func getRatesAndSave() {
        let url = GlobalUrl.get_all_rate_base_USD
        Rates.isSyncing = true
        ApiService.shared.fetchApiData(urlString: url) { data in
            if let data = data,
               let ratesResult = try? JSONDecoder().decode(RatesResult.self, from: Data(data.utf8)),
               ratesResult.success {
                Rates.timestamp = ratesResult.timestamp
                Rates.source = ratesResult.source
                Rates.quotes = ratesResult.quotes
                Rates.isSyncing = false
                DispatchQueue.main.async { [self] in
                    self.updateQuotes()
                }
            }
        }
    }
    
    func updateQuotes() {
        guard let timestamp = Rates.timestamp else { return }
        TimeLabel.text = "Rates updated(GMT): \(timestamp.toDateString())"
//        fromButton.setTitle(Rates.source, for: .normal)
        updateResult()
        tableView.reloadData()
    }
    
    func updateResult() {
        guard let mumber: Double = Double(inputTestField.text ?? "") else {
            resultLabel.text = "-- Incorrect input value --"
            return
        }
        if let rate = Rates.quotes?.first(where: {$0.key == "USDJPY"}) {
            let text = rate.value * mumber
            resultLabel.text = " = \(text)"
        }
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
