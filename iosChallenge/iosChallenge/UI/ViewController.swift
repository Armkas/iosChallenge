//
//  ViewController.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        resetUI()
        inputTextField.keyboardType = .numbersAndPunctuation
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
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
        inputTextField.text = "1.0"
        fromButton.setTitle("USD", for: .normal)
        toButton.setTitle("JPY", for: .normal)
        resultLabel.text = "-- Incorrect input value --"
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(
            UINib(nibName: "ListCell", bundle: nil),
            forCellReuseIdentifier: "ListCell"
        )
        tableView.reloadData()
    }
    
    func checkTime() {
        let now = Int(Date().timeIntervalSince1970)
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
        guard let mumber: Double = Double(inputTextField.text ?? "") else {
            resultLabel.text = "-- Incorrect input value --"
            return
        }
        if let rate = Rates.quotes?.first(where: {$0.key == "USDJPY"}) {
            let text = rate.value * mumber
            resultLabel.text = " = \(text)"
        }
    }
    
    @objc func tap() {
        view.endEditing(true)
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rates.quotes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        if let currencies = Rates.currencies,
           let rates = Rates.rates {
            cell.bind(country: currencies[indexPath.row], rate: rates[indexPath.row])
        }
        return cell
    }
}
