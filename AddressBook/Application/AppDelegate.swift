import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let component = AppComponent(
            window: window!,
            realm: try! Realm()
        )
        let windowScene = WindowScene(window: window!)
        let rootView = RootBuilderImpl(dependency: component).build()
        struct Dependency: AddContactDependency {
            let realm: Realm
        }
        windowScene.play(view: rootView)
        return true
    }
}
