import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private var launchCoordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let component = AppComponent(window: window!)
        let windowScene = WindowScene(window: window!)
        let rootView = RootBuilderImpl(dependency: component).build()
        windowScene.play(view: rootView)
        return true
    }
}
