//
//  CustomDatePickerViewController.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 5/29/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class CustomDatePickerViewController: UIViewController {
    var content: UIView!
    var pickerView: UIDatePicker!
    var done: UIButton!
    var date: String?
    var cancel: UIButton!
    var viewModel = CustomDatePickerViewModel()
    var doneCompletion: ((CustomDatePickerViewController)->Void)?
    var cancelCompletion: ((CustomDatePickerViewController)->Void)?
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.calendar = .current
        formatter.locale = .current
        return formatter
    }()
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
        date = dateFormatter.string(from: pickerView.date)
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
    }
}
