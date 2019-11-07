import UIKit
import RealmSwift

protocol RootDependency {
    var window: UIWindow { get }
    var realm: Realm { get }
}

protocol RootBuilder: AnyObject {
    func build() -> UIViewController
}

protocol RootRouter: AnyObject {
    func showContactsList()
}

protocol RootViewModel {

}
