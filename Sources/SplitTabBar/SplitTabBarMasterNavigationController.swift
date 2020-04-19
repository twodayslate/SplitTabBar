import UIKit

open class SplitTabBarMasterNavigationController: UINavigationController {
    public let navigation: SplitTabBarMasterController
    public init() {
        self.navigation = SplitTabBarMasterController()
        super.init(rootViewController: self.navigation)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
