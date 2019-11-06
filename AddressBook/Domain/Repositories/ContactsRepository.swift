//
//  ContactsRepository.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import RxSwift

protocol ContactsRepository {
    func fetchContacts() -> Observable<[Contact]>
    func searchContact(query: String) -> Observable<[Contact]>
    func saveContact(contact: Contact) -> Completable
}
