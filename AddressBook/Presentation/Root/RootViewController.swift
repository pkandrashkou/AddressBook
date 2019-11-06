//
//  RootViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class RootViewController: UINavigationController {
    /// add viewmodel here
    var router: RootRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true

        router.showContactsList()
    }
}
