//
//  AddContactRouterImpl.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

final class AddContactRouterImpl: AddContactRouter {
    private weak var listener: AddContactListener?

    init(listener: AddContactListener) {
        self.listener = listener
    }

    func close() {
        listener?.onAddedContact()
    }
}
