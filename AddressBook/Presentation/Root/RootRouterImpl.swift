//
//  RootRouter.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

final class RootRouterImpl: RootRouter {
    private let contactsListBuilder: ContactsListBuilder

    init(contactsListBuilder: ContactsListBuilder) {
        self.contactsListBuilder = contactsListBuilder
    }

    func showContactsList() {
        let coordinator = contactsListBuilder.build()
        coordinator.start()
    }
}
