import UIKit
import RealmSwift

protocol ContactsListDependency {
    var parent: UINavigationController { get }
    var realm: Realm { get }
}

protocol ContactsListCoordinator: AnyObject {
    func start()
}

protocol ContactsListRouter: AnyObject {
    func showContactDetails(id: String)
    func showAddNewContact()
}

protocol ContactsListBuilder {
    func build() -> UIViewController
}
