import UIKit
import RealmSwift

final class ContactsListComponent: AddContactDependency, ContactDetailsDependency {
    private let dependency: ContactsListDependency
    var realm: Realm { return dependency.realm }

    init(dependency: ContactsListDependency) {
        self.dependency = dependency
    }
}
