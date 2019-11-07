import UIKit
import RealmSwift

protocol AddContactDependency {
    var realm: Realm { get }
}

protocol AddContactCoordinator: AnyObject {
    func start()
    func stop()
}

protocol AddContactListener: AnyObject {
    func onAddedContact()
}

protocol AddContactRouter: AnyObject {
    func close()
}

protocol AddContactBuilder {
    func build(listener: AddContactListener) -> UIViewController
}
