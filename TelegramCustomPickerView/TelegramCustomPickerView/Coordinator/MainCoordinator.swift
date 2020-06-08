//
//  MainCoordinator.swift
//  TelegramCustomPickerView
//
//  Created by Catalina on 6/8/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(vc, animated: true)
    }
}
