//
//  RootBuilder.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

class RootBuilderImpl: RootBuilder {
    private let dependency: RootDependency

    init(dependency: RootDependency) {
        self.dependency = dependency
    }

    func build() -> RootCoordinator {
        let view = RootViewController()
        let component = RootComponent(dependency: dependency, parent: view)
        let contactsListBuilder = ContactsListBuilderImpl(dependency: component)
        let router = RootRouterImpl(contactsListBuilder: contactsListBuilder)
        view.router = router /// change later
        return RootCoordinatorImpl(window: dependency.window, view: view)
    }
}
