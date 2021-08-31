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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        NotificationCenter.default.addObserver(self, selector: #selector(changeActivityIndicator), name: Notification.Name("SyncStateChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert), name: Notification.Name("APIError"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeActivityIndicator()
    }
    
    @objc func changeActivityIndicator() {
        DispatchQueue.main.async { [self] in
            if GlobalData.isSyncing {
                activityIndicator.startAnimating()
                view.isUserInteractionEnabled = false
            } else {
                activityIndicator.stopAnimating()
                view.isUserInteractionEnabled = true
            }
            updateUI()
        }
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
    }
    
    func updateUI() {
        updateResult()
        tableView.reloadData()
        fromPicker.reloadAllComponents()
        toPicker.reloadAllComponents()
        guard let timestamp = GlobalData.timestamp else { return }
        TimeLabel.text = "Rates updated(GMT): \(timestamp.toDateString())"
    }
    
    func updateResult() {
        guard let mumber: Double = Double(inputTextField.text ?? "") else {
            resultLabel.text = "-- Incorrect input value --"
            return
        }
        if let base = GlobalData.quotes?.first(where: {$0.key == "USD\(fromCurrency)"}),
           let taget = GlobalData.quotes?.first(where: {$0.key == "USD\(toCurrency)"}) {
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
    
    @objc func appWillEnterForeground() {
        let now = Int(Date().timeIntervalSince1970)
        if let lastAccessTime = GlobalData.lastAccessTime,
           now - lastAccessTime > 1800 { //30 min
            ApiService.shared.getRatesAndSave()
        }
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "API Error", message: "Please Check you network, or contact support@apilayer.com", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalData.quotes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        if let currency_rate = GlobalData.currency_rate {
            cell.bind(currency_rate[indexPath.row])
        }
        return cell
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        GlobalData.currencies?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GlobalData.currencies?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == fromPicker {
            if let currency = GlobalData.currencies?[row] {
                self.fromButton.setTitle(currency, for: .normal)
                self.fromCurrency = currency
            }
            self.fromPicker.isHidden = true
        } else {
            if let currency = GlobalData.currencies?[row] {
                self.toButton.setTitle(currency, for: .normal)
                self.toCurrency = currency
            }
            self.toPicker.isHidden = true
        }
    }
}
