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

    func build() -> UIViewController {
        let view = RootViewController()
        let component = RootComponent(dependency: dependency, parent: view)
        let contactsListBuilder = ContactsListBuilderImpl(dependency: component)
        let scene = NavigationScene(parent: view)
        let router = RootRouterImpl(scene: scene, contactsListBuilder: contactsListBuilder)
        view.router = router /// change later
        return view
    }
}
