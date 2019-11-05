//
//  ContactsListCoordinatorImpl.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactsListCoordinatorImpl: ContactsListCoordinator {
    private unowned let parent: UIViewController
    private let view: UIViewController

    init(parent: UIViewController, view: UIViewController) {
        self.parent = parent
        self.view = view
    }

    func start() {
        parent.show(view, sender: nil)
    }
}
