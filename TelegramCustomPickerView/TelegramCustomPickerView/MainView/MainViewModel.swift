//
//  MainViewModel.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 6/8/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class MainViewModel {
    var contentView: UIView!
    var countryLabel: UILabel!
    var countriesTextField: UITextField!
    var dateLabel: UILabel!
    var dateTextField: UITextField!
    init() {
        addContentView()
        configureTextFields()
        configureLabels()
    }
    private func addContentView() {
        contentView = UIView()
        contentView.backgroundColor = GlobalSettings.shared().lightGray
    }
    private func configureLabels() {
        countryLabel = addLabel(withText: "Country:")
        addConstraint(toLabel: countryLabel, view: countriesTextField)
        dateLabel = addLabel(withText: "Date:")
        addConstraint(toLabel: dateLabel, view: dateTextField)
    }
    private func configureTextFields() {
        countriesTextField = addTextField(placeholder: "Select a Country")
        addConstraint(toTextField: countriesTextField, distance: 100)
        dateTextField = addTextField(placeholder: "Pick a Date")
        addConstraint(toTextField: dateTextField, distance: 220)
    }
    //MARK:- Helper Methods
    private func addLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .purple
        label.font = GlobalSettings.shared().boldSystemFont(size: 15)
        return label
    }
    private func addConstraint(toLabel label: UILabel, view: UIView) {
       label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45)])
    }
    private func addTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.tintColor = GlobalSettings.shared().darkGray
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.font = GlobalSettings.shared().boldSystemFont(size: 15)
        return textField
    }
    private func addConstraint(toTextField textField: UITextField, distance: CGFloat) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: distance),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -200),
            textField.heightAnchor.constraint(equalToConstant: 50)])
    }
}
