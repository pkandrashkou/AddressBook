//
//  ContactDetailsCoordinatorImpl.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactDetailsCoordinatorImpl: ContactDetailsCoordinator {
    private let parent: UIViewController
    private weak var view: UIViewController?

    init(parent: UIViewController, view: UIViewController) {
        self.parent = parent
        self.view = view
    }

    func start() {
        guard let view = self.view else {
            assertionFailure("Cannot start \(String(describing: self)), view is not set.")
            return
        }
        parent.show(view, sender: nil)
    }
}
