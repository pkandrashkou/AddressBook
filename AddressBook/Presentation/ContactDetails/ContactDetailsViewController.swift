//
//  ContactDetailsViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactDetailsViewController: UIViewController, ContactDetailsCoordinatorProvidable {
    var coordinator: ContactDetailsCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    deinit {
        print("deinit ContactDetailsViewController")
    }
}
