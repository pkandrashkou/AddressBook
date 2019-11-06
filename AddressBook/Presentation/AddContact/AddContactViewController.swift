//
//  AddContactViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class AddContactViewController: UIViewController, AddContactCoordinatorProvidable {
    var coordinator: AddContactCoordinator!
    var router: AddContactRouter! //fix

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(self.onClose))
    }

    deinit {
        print("deinit AddContactViewController")
    }

    @objc func onClose() {
        router.close()
    }
}
