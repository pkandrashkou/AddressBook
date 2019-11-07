import UIKit
import RealmSwift

protocol ContactDetailsDependency {
    var realm: Realm { get }
}

protocol ContactDetailsBuilder {
    func build(contactId: String) -> UIViewController
}
