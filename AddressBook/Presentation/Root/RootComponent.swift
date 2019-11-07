import UIKit
import RealmSwift

final class RootComponent: ContactsListDependency {
    private let dependency: RootDependency
    let parent: UINavigationController
    var realm: Realm { return dependency.realm }

    init(dependency: RootDependency, parent: UINavigationController) {
        self.dependency = dependency
        self.parent = parent
    }
}
