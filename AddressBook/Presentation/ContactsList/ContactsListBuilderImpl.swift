//
//  ContactListBuilder.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactsListBuilderImpl: ContactsListBuilder {
    private let dependency: ContactsListDependency

    init(dependency: ContactsListDependency) {
        self.dependency = dependency
    }

    func build() -> UIViewController {

        let interactor = ContactListInteractorImpl(contactsRepository: ContactsRepositoryStubImpl())
        let viewModel = ContactsListViewModel(interactor: interactor)
        let view = ContactsListViewController(viewModel: viewModel)
        let component = ContactsListComponent(dependency: dependency, parent: view)
        let addContactBuilder = AddContactBuilderImpl(dependency: component)
        let contactDetailsBuilder = ContactDetailsBuilderImpl(dependency: component)

        let navigationScene = NavigationScene(parent: dependency.parent)
        let presentationScene = PresentationScene(parent: dependency.parent)
        let router = ContactsListRouterImpl(
            navigationScene: navigationScene,
            presentationScene: presentationScene,
            addContactBuilder: addContactBuilder,
            contactDetailsBuilder: contactDetailsBuilder
        )

        view.router = router //change
        return view
    }
}
