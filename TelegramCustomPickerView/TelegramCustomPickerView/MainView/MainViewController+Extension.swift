//
//  MainViewController+Extension.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 6/8/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        switch textField {
        case countriesTextField:
            configureCountriesTextFieldSelection()
        case dateTextField:
            configureDateTextField()
        default:
            return
        }
    }
    func configureCountriesTextFieldSelection(){
        let vc = CustomPickerViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.pickerDataSource = countryNames
        if let index = selectedIndex {
            vc.selectedIndex = index
        }
        present(vc, animated: true, completion: nil)
        vc.doneCompletion = { [weak self] picker in
            self?.selectedIndex = picker.selectedIndex
            self?.countriesTextField.text = picker.selectedItem
            picker.dismiss(animated: true, completion: nil)
        }
        vc.cancelCompletion = {picker in
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func configureDateTextField() {
        let vc = CustomDatePickerViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        if let date = date {
            vc.date = dateFormatter.string(from: date)
            vc.pickerView.setDate(date, animated: true)
        }
        vc.doneCompletion = { [weak self] picker in
            if let date = picker.date {
                self?.date = self?.dateFormatter.date(from: date)
                self?.dateTextField.text = date
            }
            picker.dismiss(animated: true, completion: nil)
        }
        vc.cancelCompletion = { picker in
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
