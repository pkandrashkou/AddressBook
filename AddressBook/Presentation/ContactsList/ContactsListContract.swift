//
//  ContactsListContract.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

protocol ContactsListDependency {
    var parent: UIViewController { get }
}

protocol ContactsListCoordinator: AnyObject {
    func start()
}

protocol ContactsListViewModel: AnyObject {

}

protocol ContactsListRouter: AnyObject {
    func showContactDetails(id: String)
    func showAddNewContact()
}

protocol ContactsListBuilder {
    func build() -> ContactsListCoordinator
}
