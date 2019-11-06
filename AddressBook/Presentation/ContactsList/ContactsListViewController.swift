//
//  ContactsListViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactsListViewController: UIViewController {
    var router: ContactsListRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(self.onAddButtonPress))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "details", style: .plain, target: self, action: #selector(self.onDetailsPress))
    }

    deinit {
        print("deinit ContactsListViewController")
    }

    @objc func onAddButtonPress() {
        router.showAddNewContact()
    }

    @objc func onDetailsPress() {
        router.showContactDetails(id: "id")
    }
}
