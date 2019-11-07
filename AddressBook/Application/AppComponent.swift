import UIKit
import RealmSwift

final class AppComponent: RootDependency {
    unowned let window: UIWindow
    let realm: Realm

    init(window: UIWindow, realm: Realm) {
        self.window = window
        self.realm = realm
    }
}
