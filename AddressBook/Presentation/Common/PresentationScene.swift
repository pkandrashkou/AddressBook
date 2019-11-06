//
//  PresentationScene.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

class PresentationScene {
    let parent: UIViewController

    init(parent: UIViewController) {
        self.parent = parent
    }

    func play(view: UIViewController) {
        parent.present(view, animated: true, completion: nil)
    }

    func stop() {
        parent.dismiss(animated: true, completion: nil)
    }
}
