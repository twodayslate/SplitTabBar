import UIKit

open class SplitTabBarMasterNavigationController: UINavigationController {
    public let navigation: SplitTabBarMasterController

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.navigation = SplitTabBarMasterController()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public init(navigation: SplitTabBarMasterController) {
        self.navigation = navigation
        super.init(rootViewController: self.navigation)
    }

    public convenience init() {
        self.init(navigation: SplitTabBarMasterController())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
