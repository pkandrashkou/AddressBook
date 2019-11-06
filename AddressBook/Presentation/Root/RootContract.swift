//
//  RootContract.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

protocol RootDependency {
    var window: UIWindow { get }
}

protocol RootBuilder: AnyObject {
    func build() -> UIViewController
}

protocol RootRouter: AnyObject {
    func showContactsList()
}

protocol RootViewModel {

}

protocol RootCoordinator: AnyObject {
    func start()
}
