//
//  CustomPickerViewController.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 5/27/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit

class CustomPickerViewController: UIViewController {
    var content: UIView!
    var pickerView: UIPickerView!
    var done: UIButton!
    var cancel: UIButton!
    var viewModel = CustomPickerViewModel()
    var pickerDataSource: [String]!
    var selectedIndex: Int?
    var selectedItem: String?
    var doneCompletion: ((CustomPickerViewController)->Void)?
    var cancelCompletion: ((CustomPickerViewController)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnView(tapGestureRecognizer:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        configureBackground()
        configureContent()
        configureCancelButton()
        configureDoneButton()
        configurePickerView()
    }
    @objc func didTapDoneButton(sender: UIButton) {
        selectedIndex = pickerView.selectedRow(inComponent: 0)
        selectedItem = pickerDataSource[selectedIndex!]
        doneCompletion?(self)
    }
    @objc func didTapCancelButton(sender: UIButton) {
        cancelCompletion?(self)
    }
    @objc func didTapOnView(tapGestureRecognizer: UITapGestureRecognizer){
        let point = tapGestureRecognizer.location(in: self.view)
        if !pickerView.frame.contains(point) && !cancel.frame.contains(point) {
            dismiss(animated: true, completion: nil)
        }
    }
    func configureBackground(){
        let background = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        background.backgroundColor = .lightGray
        background.alpha = 0.6
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        view.sendSubviewToBack(background)
    }
    func configureContent(){
        content = viewModel.content
        view.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: view.topAnchor),
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    func configureCancelButton(){
        cancel = viewModel.cancel
        cancel.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    func configureDoneButton(){
        done = viewModel.done
        done.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    }
    func configurePickerView(){
        pickerView = viewModel.pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        if let index = selectedIndex {
            pickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }
}
extension CustomPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
}
