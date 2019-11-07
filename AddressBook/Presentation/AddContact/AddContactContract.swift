//
//  AddContactContract.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

protocol AddContactDependency { }

protocol AddContactCoordinator: AnyObject {
    func start()
    func stop()
}

protocol AddContactListener: AnyObject {
    func onAddedContact()
}

protocol AddContactRouter: AnyObject {
    func close()
}

protocol AddContactBuilder {
    func build(listener: AddContactListener) -> UIViewController
}
