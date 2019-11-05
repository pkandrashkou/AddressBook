//
//  AppComponent.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class AppComponent: RootDependency {
    unowned let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}
