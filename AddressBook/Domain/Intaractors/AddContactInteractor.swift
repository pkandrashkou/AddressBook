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

final class AddContactInteractorImpl: AddContactInteractor {
    func validate(email: String) -> Single<Bool> {
        return Single.create(subscribe: { single in
            single(.success(false))
            return Disposables.create()
        })
    }

    func saveContact(contact: Contact) -> Completable {
        fatalError()
    }
}
