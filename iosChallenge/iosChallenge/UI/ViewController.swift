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
    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    
    private var fromCurrency: String = "USD" {
        didSet {
            updateResult()
        }
    }
    private var toCurrency: String = "JPY" {
        didSet {
            updateResult()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUI()
        inputTextField.keyboardType = .numbersAndPunctuation
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
        fromPicker.dataSource = self
        fromPicker.delegate = self
        toPicker.dataSource = self
        toPicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    @IBAction func fromButtonClicked(_ sender: UIButton) {
        fromPicker.isHidden = false
    }
    
    @IBAction func toButtonClicked(_ sender: UIButton) {
        toPicker.isHidden = false
    }
    
    @IBAction func doConvert(_ sender: UIButton) {
        updateResult()
    }
    
    func resetUI() {
        inputTextField.text = "1.0"
        fromButton.setTitle(fromCurrency, for: .normal)
        toButton.setTitle(toCurrency, for: .normal)
        resultLabel.text = "-- Incorrect input value --"
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "ListCell", bundle: nil),
            forCellReuseIdentifier: "ListCell"
        )
        guard let timestamp = Rates.timestamp else { return }
        TimeLabel.text = "Rates updated(GMT): \(timestamp.toDateString())"
    }
    
    func updateUI() {
        updateResult()
        tableView.reloadData()
    }
    
    func updateResult() {
        guard let mumber: Double = Double(inputTextField.text ?? "") else {
            resultLabel.text = "-- Incorrect input value --"
            return
        }
        if let base = Rates.quotes?.first(where: {$0.key == "USD\(fromCurrency)"}),
           let taget = Rates.quotes?.first(where: {$0.key == "USD\(toCurrency)"}) {
            let rate = taget.value / base.value // e.g.: JPYCNY == USDCNY / USDJPY
            let text = rate * mumber
            resultLabel.text = " = \(text)"
        }
    }
    
    @objc func tap() {
        view.endEditing(true)
        fromPicker.isHidden = true
        toPicker.isHidden = true
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rates.quotes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        if let country_rate = Rates.country_rate {
            cell.bind(country_rate[indexPath.row])
        }
        return cell
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Rates.countries?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Rates.countries?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == fromPicker {
            if let country = Rates.countries?[row] {
                self.fromButton.setTitle(country, for: .normal)
                self.fromCurrency = country
            }
            self.fromPicker.isHidden = true
        } else {
            if let country = Rates.countries?[row] {
                self.toButton.setTitle(country, for: .normal)
                self.toCurrency = country
            }
            self.toPicker.isHidden = true
        }
    }
}
