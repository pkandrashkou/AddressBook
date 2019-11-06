//
//  ContactListInteractor.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import RxSwift

protocol ContactListInteractor {
    func fetchContacts() -> Observable<[Contact]>
    func searchContact(query: String) -> Observable<[Contact]>
}

final class ContactListInteractorImpl: ContactListInteractor {
    private let contactsRepository: ContactsRepository

    init(contactsRepository: ContactsRepository) {
        self.contactsRepository = contactsRepository
    }

    func fetchContacts() -> Observable<[Contact]> {
        return contactsRepository.fetchContacts()
    }

    func searchContact(query: String) -> Observable<[Contact]> {
        return contactsRepository.searchContact(query: query)
    }
}
