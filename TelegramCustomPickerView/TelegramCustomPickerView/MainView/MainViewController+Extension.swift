//
//  MainViewController+Extension.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 6/8/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case countriesTextField:
            showTextFeildPicker(textField: countriesTextField, dataSource: countryNames, selectedIndex: selectedIndex) { [weak self] result in
                self?.countriesTextField.text = result.text
                self?.selectedIndex = result.index
            }
            return false
        case dateTextField:
            showTextFieldDatePicker(textField: dateTextField, date: date){ [weak self] date in
                guard let date = date else {return}
                self?.date = date
                self?.dateTextField.text = self?.dateFormatter.string(from: date)
            }
            return false
        default:
            return true
        }
    }
    func showTextFeildPicker(textField: UITextField, dataSource: [String], selectedIndex: Int?, completion: @escaping ((text: String?, index: Int?)) -> Void) {
        var text: String?
        var index: Int?
        let vc = CustomPickerViewController()
        vc.pickerDataSource = dataSource
        if let index = selectedIndex {
            vc.selectedIndex = index
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        vc.doneCompletion = { picker in
            text = picker.selectedItem
            index = picker.selectedIndex
            completion((text, index))
            picker.dismiss(animated: true, completion: nil)
        }
        vc.cancelCompletion = { picker in
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func showTextFieldDatePicker(textField: UITextField, date: Date?, completion: @escaping (Date?) -> Void) {
        let vc = CustomDatePickerViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        if let date = date {
            vc.date = date
            vc.pickerView.setDate(date, animated: true)
        }
        vc.doneHandler = { picker in
            completion(picker.date)
            picker.dismiss(animated: true, completion: nil)
        }
        vc.cancelHandler = { picker in
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
