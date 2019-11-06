//
//  ContactListBuilder.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactDetailsBuilderImpl: ContactDetailsBuilder {
    private let dependency: ContactDetailsDependency

    init(dependency: ContactDetailsDependency) {
        self.dependency = dependency
    }

    func build(contactId: String) -> UIViewController {
        let view = ContactDetailsViewController()
//        let coordinator = ContactDetailsCoordinatorImpl(parent: dependency.parent, view: view)
//        view.coordinator = coordinator
        return view
    }
}
