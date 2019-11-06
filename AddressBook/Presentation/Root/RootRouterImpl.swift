//
//  RootRouter.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

final class RootRouterImpl: RootRouter {
    private let scene: NavigationScene
    private let contactsListBuilder: ContactsListBuilder

    init(scene: NavigationScene, contactsListBuilder: ContactsListBuilder) {
        self.scene = scene
        self.contactsListBuilder = contactsListBuilder
    }

    func showContactsList() {
        let view = contactsListBuilder.build()
        scene.play(view: view)
    }
}
