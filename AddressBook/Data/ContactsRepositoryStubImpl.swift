//
//  ContactsRepositoryStubImpl.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import RxSwift

final class ContactsRepositoryStubImpl: ContactsRepository {
    func fetchContacts() -> Observable<[Contact]> {
        return Observable.create {
            let stubbed =
                [
                    Contact(firstName: "Boy", lastName: "Delves", email: "bdelves0@angelfire.com", phoneNumber: "+63 (665) 466-7497", address: "Tapilon"),
                    Contact(firstName: "Michail", lastName: "Coupman", email: "mcoupman1@typepad.com", phoneNumber: "+62 (981) 667-8329", address: "Wahawaha"),
                    Contact(firstName: "Jsandye", lastName: "Vipan", email: "jvipan2@apache.org", phoneNumber: "+675 (569) 102-7465", address: "Rabaul"),
                    Contact(firstName: "Stacie", lastName: "Salkild", email: "ssalkild3@newyorker.com", phoneNumber: "+86 (500) 829-3250", address: "Zhanjia"),
                    Contact(firstName: "Gwendolin", lastName: "Ribou", email: "gribou4@hugedomains.com", phoneNumber: "+66 (315) 554-8485", address: "Taling Chan")
            ]
            $0.onNext(stubbed)
            $0.onCompleted()

            return Disposables.create()
        }
    }

    func searchContact(query: String) -> Observable<[Contact]> {
        return Observable.create {
            let stubbed =
                [
                    Contact(firstName: "Boy", lastName: "Delves", email: "bdelves0@angelfire.com", phoneNumber: "+63 (665) 466-7497", address: "Tapilon"),
                    Contact(firstName: "Michail", lastName: "Coupman", email: "mcoupman1@typepad.com", phoneNumber: "+62 (981) 667-8329", address: "Wahawaha"),
                    Contact(firstName: "Jsandye", lastName: "Vipan", email: "jvipan2@apache.org", phoneNumber: "+675 (569) 102-7465", address: "Rabaul"),
                    Contact(firstName: "Stacie", lastName: "Salkild", email: "ssalkild3@newyorker.com", phoneNumber: "+86 (500) 829-3250", address: "Zhanjia"),
                    Contact(firstName: "Gwendolin", lastName: "Ribou", email: "gribou4@hugedomains.com", phoneNumber: "+66 (315) 554-8485", address: "Taling Chan")
            ]
            $0.onNext(stubbed)
            $0.onCompleted()

            return Disposables.create()
        }
    }

    func saveContact(contact: Contact) -> Completable {
        return Completable.create { (completable) -> Disposable in
            completable(.completed)
            return Disposables.create()
        }
    }
}
