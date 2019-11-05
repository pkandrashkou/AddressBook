//
//  ContactListBuilder.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

final class ContactsListBuilderImpl: ContactsListBuilder {
    private let dependency: ContactsListDependency

    init(dependency: ContactsListDependency) {
        self.dependency = dependency
    }

    func build() -> ContactsListCoordinator {
        let view = ContactsListViewController()
        let coordinator = ContactsListCoordinatorImpl(parent: dependency.parent, view: view)
        return coordinator
    }
}
