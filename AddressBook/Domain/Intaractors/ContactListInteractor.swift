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
