//
//  ContactListNavigationScene.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

class NavigationScene {
    let parent: UINavigationController

    init(parent: UINavigationController) {
        self.parent = parent
    }

    func play(view: UIViewController) {
        parent.pushViewController(view, animated: true)
    }

    func stop() {
        parent.popViewController(animated: true)
    }
}
