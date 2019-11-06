//
//  ContactsListViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit
import SnapKit

final class ContactsListViewController: UIViewController {
    private enum State {
        case loading
        case noContacts
        case hasContacts
    }

    private var state: State = .loading {
        didSet {
            updateState(state: state)
        }
    }

    private let tableView = UITableView()
    private let noContactsView = ContactsListNoContactsView()

    var router: ContactsListRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Address Book"
        updateState(state: .noContacts)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(self.onAddButtonPress))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "details", style: .plain, target: self, action: #selector(self.onDetailsPress))
    }

    @objc func onAddButtonPress() {
        router.showAddNewContact()
    }

    @objc func onDetailsPress() {
        router.showContactDetails(id: "id")
    }

    private func updateState(state: State) {
        switch state {
        case .loading:
            tableView.removeFromSuperview()
            tableView.snp.removeConstraints()
            noContactsView.removeFromSuperview()
            noContactsView.snp.removeConstraints()
        case .hasContacts:
            view.addSubview(tableView)
            tableView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case .noContacts:
            view.addSubview(noContactsView)
            noContactsView.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.leading.greaterThanOrEqualToSuperview()
                $0.trailing.lessThanOrEqualToSuperview()
            }
        }
    }
}
