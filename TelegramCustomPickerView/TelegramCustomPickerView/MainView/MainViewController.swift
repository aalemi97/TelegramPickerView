//
//  ViewController.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 6/8/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class MainViewController: UIViewController {
    //MARK:- Variables
    weak var coordinator: MainCoordinator?
    let viewModel = MainViewModel()
    var contentView: UIView!
    var countriesTextField: UITextField!
    var dateTextField: UITextField!
    var countryNames = [String]()
    var date: Date?
    var selectedIndex: Int?
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.calendar = .current
        formatter.locale = .current
        return formatter
    }()
    //MARK:- Actions
    @objc func didTapOnView(tapGestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    //MARK:- View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GlobalSettings.shared().lightGray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnView(tapGestureRecognizer:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        addContentView()
        if let data = readLocalFile(forName: "countries") {
            parse(jsonData: data)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //MARK:- View Layout
    func addContentView() {
        contentView = viewModel.contentView
        countriesTextField = viewModel.countriesTextField
        countriesTextField.delegate = self
        dateTextField = viewModel.dateTextField
        dateTextField.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    //MARK:- Data
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([Country].self, from: jsonData)
            for i in 0..<decodedData.count {
                countryNames.append(decodedData[i].name)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

