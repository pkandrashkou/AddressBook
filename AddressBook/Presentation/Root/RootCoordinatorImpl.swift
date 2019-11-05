//
//  RootCoordinator.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class RootCoordinatorImpl: RootCoordinator {
    private let window: UIWindow
    private var view: UIViewController

    init(window: UIWindow, view: UIViewController) {
        self.window = window
        self.view = view
    }

    func start() {
        window.rootViewController = view
        window.makeKeyAndVisible()
    }
}
