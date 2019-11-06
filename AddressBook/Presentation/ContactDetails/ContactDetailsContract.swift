//
//  ContactDetailsContract.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

protocol ContactDetailsDependency { }

protocol ContactDetailsViewModel: AnyObject {

}

protocol ContactDetailsBuilder {
    func build(contactId: String) -> UIViewController
}
