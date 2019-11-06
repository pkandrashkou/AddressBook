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
    let parent: UINavigationController

    init(dependency: RootDependency, parent: UINavigationController) {
        self.dependency = dependency
        self.parent = parent
    }
}
