//
//  AddContactInteractor.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import RxSwift
import RxCocoa

enum AddContactError: Error {
    case invalidEmail
}

protocol AddContactInteractor {
    func validate(email: String) -> Single<Bool>
    func saveContact(contact: NewContact) -> Single<Contact>
}

final class AddContactInteractorImpl: AddContactInteractor {
    private let contactsRepository: ContactsRepository
    private let emailValidationUseCase: EmailValidationUseCase

    init(contactsRepository: ContactsRepository,
         emailValidationUseCase: EmailValidationUseCase) {
        self.contactsRepository = contactsRepository
        self.emailValidationUseCase = emailValidationUseCase
    }

    func validate(email: String) -> Single<Bool> {
        return Single.create(subscribe: { [weak self] single in
            guard let self = self else {
                single(.success(false))
                return Disposables.create()
            }

            let isValid = self.emailValidationUseCase.validate(email: email)
            single(.success(isValid))
            return Disposables.create()
        })
    }

    func saveContact(contact: NewContact) -> Single<Contact> {
        let created = Contact(
            id: "someId",
            firstName: contact.firstName,
            lastName: contact.lastName,
            email: contact.email,
            phoneNumber: contact.phoneNumber,
            address: contact.address
        )
        return contactsRepository.saveContact(contact: created)
            .andThen(Single.just(created))
    }
}
