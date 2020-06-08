//
//  CustomPickerViewModel.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 5/27/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class CustomPickerViewModel {
    var content: UIView!
    var picker: UIView!
    var pickerView: UIPickerView!
    let pickerViewHeight: CGFloat = 216
    var done: UIButton!
    var cancel: UIButton!
    let buttonHeight: CGFloat = 60
    init() {
        configureContent()
        configureCancelButton()
        configurePicker()
    }
    private func configureContent(){
        content = UIView(frame: .zero)
        content.backgroundColor = .none
        content.translatesAutoresizingMaskIntoConstraints = false
    }
    private func configureCancelButton(){
        cancel = UIButton(frame: .zero)
        cancel.backgroundColor = GlobalSettings.shared().lightGray
        cancel.setTitle("Cancel", for: .normal)
        cancel.titleLabel?.textAlignment = .center
        cancel.titleLabel?.font = .systemFont(ofSize: 20)
        cancel.setTitleColor(GlobalSettings.shared().mainColor, for: .normal)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(cancel)
        NSLayoutConstraint.activate([
            cancel.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -30),
            cancel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            cancel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            cancel.heightAnchor.constraint(equalToConstant: buttonHeight)])
        makeRounded(item: cancel, radius: 15)
    }
    private func configurePicker(){
        picker = UIView(frame: .zero)
        picker.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.bottomAnchor.constraint(equalTo: cancel.topAnchor, constant: -8),
            picker.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            picker.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            picker.heightAnchor.constraint(equalToConstant: pickerViewHeight + buttonHeight)])
        makeRounded(item: picker)
        configureDoneButton()
        configurePickerView()
    }
    private func configureDoneButton(){
        done = UIButton(frame: .zero)
        done.backgroundColor = GlobalSettings.shared().lightGray
        done.setTitle("Done", for: .normal)
        done.titleLabel?.textAlignment = .center
        done.titleLabel?.font = .systemFont(ofSize: 20)
        done.setTitleColor(GlobalSettings.shared().mainColor, for: .normal)
        done.translatesAutoresizingMaskIntoConstraints = false
        picker.addSubview(done)
        NSLayoutConstraint.activate([
            done.bottomAnchor.constraint(equalTo: picker.bottomAnchor),
            done.leadingAnchor.constraint(equalTo: picker.leadingAnchor),
            done.trailingAnchor.constraint(equalTo: picker.trailingAnchor),
            done.heightAnchor.constraint(equalToConstant: buttonHeight)])
        makeRounded(item: done, radius: 0)
    }
    private func configurePickerView(){
        pickerView = UIPickerView(frame: .zero)
        pickerView.backgroundColor = GlobalSettings.shared().lightGray
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        picker.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.bottomAnchor.constraint(equalTo: done.topAnchor),
            pickerView.leadingAnchor.constraint(equalTo: picker.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: picker.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: pickerViewHeight)])
    }
    private func makeRounded(item: UIView, radius: CGFloat = 20){
        item.layer.cornerRadius = radius
        item.layer.borderColor = UIColor.darkGray.cgColor
        item.layer.borderWidth = 0.5
        item.layer.masksToBounds = true
    }
}
