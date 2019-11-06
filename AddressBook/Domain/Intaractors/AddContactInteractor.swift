//
//  AddContactInteractor.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import RxSwift

enum AddContactError: Error {
    case invalidEmail
}

protocol AddContactInteractor {
    func validate(email: String) -> Single<Bool>
    func saveContact(contact: Contact) -> Completable
}
