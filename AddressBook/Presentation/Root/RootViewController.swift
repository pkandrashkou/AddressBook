import UIKit

final class RootViewController: UINavigationController {
    var router: RootRouter! /// shortcut

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true

        router.showContactsList()
    }
}
