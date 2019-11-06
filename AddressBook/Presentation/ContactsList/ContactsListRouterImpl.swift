//
//  ContactListRouter.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

final class ContactsListRouterImpl: ContactsListRouter {
    private let navigationScene: NavigationScene
    private let presentationScene: PresentationScene

    private let addContactBuilder: AddContactBuilder
    private let contactDetailsBuilder: ContactDetailsBuilder

    init(navigationScene: NavigationScene,
         presentationScene: PresentationScene,
         addContactBuilder: AddContactBuilder,
         contactDetailsBuilder: ContactDetailsBuilder) {
        self.navigationScene = navigationScene
        self.presentationScene = presentationScene
        self.addContactBuilder = addContactBuilder
        self.contactDetailsBuilder = contactDetailsBuilder
    }

    func showContactDetails(id: String) {
        let view = contactDetailsBuilder.build(contactId: id)
        navigationScene.play(view: view)
    }

    func showAddNewContact() {
        let view = addContactBuilder.build(listener: self)
        presentationScene.play(view: view)
    }
}

extension ContactsListRouterImpl: AddContactListener {
    func onAddedContact() {
        presentationScene.stop()
    }
}
