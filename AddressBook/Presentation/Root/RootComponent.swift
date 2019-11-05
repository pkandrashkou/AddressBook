//
//  RootComponent.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class RootComponent: ContactsListDependency {
    private let dependency: RootDependency
    let parent: UIViewController

    init(dependency: RootDependency, parent: UIViewController) {
        self.dependency = dependency
        self.parent = parent
    }
}
