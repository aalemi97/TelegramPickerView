//
//  DeepMindsNavigationController.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 6/8/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class DeepMindsNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var customNavBar: UIView!
    let label = UILabel()
    let itemHeight: CGFloat = 50
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    func configureView() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.tintColor = GlobalSettings.shared().lightGray
        navigationBar.isTranslucent = false
        navigationBar.layer.borderColor = .none
        navigationBar.layer.borderWidth = 0
        customNavBar = UIView(frame: CGRect(x: 0, y: navigationBar.bounds.maxY, width: navigationBar.bounds.width, height: navigationBar.bounds.height+80))
        customNavBar.backgroundColor = .purple
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customNavBar)
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 120)])
        applyCurvedPath(givenView: customNavBar, curvedPercent: 0.3)
        addLabel(with: "Deep Minds")
    }
    func addLabel(with title: String) {
        label.textColor = .white
        label.text = title
        label.textAlignment = .left
        label.font = GlobalSettings.shared().boldSystemFont()
        label.translatesAutoresizingMaskIntoConstraints = false
        customNavBar.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: itemHeight)])
    }
    func pathCurvedForView(givenView: UIView, curvedPercent:CGFloat)->UIBezierPath{
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x:0, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)))
        arrowPath.addQuadCurve(to: CGPoint(x:0, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:givenView.bounds.size.width/2, y:givenView.bounds.size.height))
        arrowPath.addLine(to: CGPoint(x:0, y:0))
        arrowPath.close()
        return arrowPath
    }
    func applyCurvedPath(givenView: UIView,curvedPercent:CGFloat){
        guard curvedPercent <= 1 && curvedPercent >= 0 else{ return }
        let shapeLayer = CAShapeLayer(layer: givenView.layer)
        shapeLayer.path = pathCurvedForView(givenView: givenView,curvedPercent: curvedPercent).cgPath
        shapeLayer.frame = givenView.bounds
        shapeLayer.masksToBounds = true
        givenView.layer.mask = shapeLayer
    }
}
