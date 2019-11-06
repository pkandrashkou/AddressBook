//
//  ContactsListComponent.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactsListComponent: AddContactDependency, ContactDetailsDependency {
    private let dependency: ContactsListDependency
    let parent: UIViewController

    init(dependency: ContactsListDependency, parent: UIViewController) {
        self.dependency = dependency
        self.parent = parent
    }
}
