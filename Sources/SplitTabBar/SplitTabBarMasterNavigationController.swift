import UIKit

class SplitTabBarMasterNavigationController: UINavigationController {
    let navigation: SplitTabBarMasterController
    init() {
        self.navigation = SplitTabBarMasterController()
        super.init(rootViewController: self.navigation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
