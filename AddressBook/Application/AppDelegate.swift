import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let component = AppComponent(window: window!)
        let windowScene = WindowScene(window: window!)
        let rootView = RootBuilderImpl(dependency: component).build()
        struct Dependency: AddContactDependency {
//            var parent: UIViewController
        }
//        let rootView = AddContactBuilderImpl(dependency: Dependency()).build(listener: self)
        windowScene.play(view: rootView)
        return true
    }
}

//extension AppDelegate: AddContactListener {
//    func onAddedContact() {
//        //noop
//    }
//}
