import UIKit

class NavigationScene {
    let parent: UINavigationController

    init(parent: UINavigationController) {
        self.parent = parent
    }

    func play(view: UIViewController) {
        parent.pushViewController(view, animated: true)
    }

    func stop() {
        parent.popViewController(animated: true)
    }
}
