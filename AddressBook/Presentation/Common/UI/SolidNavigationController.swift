import UIKit

class SolidNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()

        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.title3]

    }
}
