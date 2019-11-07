import UIKit

final class WindowScene {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func play(view: UIViewController) {
        window.rootViewController = view
        window.makeKeyAndVisible()
    }
}
