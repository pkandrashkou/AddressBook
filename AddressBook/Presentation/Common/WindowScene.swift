//
//  WindowScene.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class WindowScene {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func play(view: UIViewController) {
        window.rootViewController = view
        window.makeKeyAndVisible()
    }
}
