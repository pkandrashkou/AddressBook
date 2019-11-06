//
//  ContactListViewModel.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import RxCocoa
import RxSwift

final class ContactsListViewModel {
    let input: Input
    let output: Output

    struct Input { }

    struct Output {
        let contacts: Observable<[Contact]>
    }

    init(interactor: ContactListInteractor) {
        input = Input()
        output = Output(
            contacts: interactor.fetchContacts()
        )
    }
}
