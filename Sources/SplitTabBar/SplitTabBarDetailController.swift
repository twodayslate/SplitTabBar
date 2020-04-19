import UIKit

open class SplitTabBarDetailController: UITabBarController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    open var selectedViewControllerIndex: Int {
        guard let selectedVC = self.selectedViewController else {
            return -1
        }

        return self.viewControllers?.firstIndex(of: selectedVC) ?? -1
    }

    open override func tabBar(
        _ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool
    ) {
        super.tabBar(tabBar, willEndCustomizing: items, changed: changed)
        (self.splitViewController as? SplitTabBarViewController)?.masterNavigation.navigation
            .tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }

    open override var viewControllers: [UIViewController]? {
        didSet {

            (self.splitViewController as? SplitTabBarViewController)?.masterNavigation.navigation
                .tableView.reloadData()
        }
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        (self.splitViewController as? SplitTabBarViewController)?.masterNavigation.navigation
            .tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }

    public private(set) var originalMoreTableViewDelegate: UITableViewDelegate?
}

extension SplitTabBarDetailController: UITabBarControllerDelegate {
    open func tabBarController(
        _ tabBarController: UITabBarController, didSelect viewController: UIViewController
    ) {
        // https://stackoverflow.com/a/52181877/193772
        if viewController == self.moreNavigationController,
            let moreTableView = tabBarController.moreNavigationController.topViewController?.view
                as? UITableView
        {
            if originalMoreTableViewDelegate == nil {
                originalMoreTableViewDelegate = moreTableView.delegate
            }

            moreTableView.delegate = self
        }

        (self.splitViewController as? SplitTabBarViewController)?.masterNavigation.navigation
            .tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
}

extension SplitTabBarDetailController: UITableViewDelegate {
    // https://stackoverflow.com/a/52181877/193772
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        originalMoreTableViewDelegate?.tableView?(tableView, didSelectRowAt: indexPath)

        (self.splitViewController as? SplitTabBarViewController)?.masterNavigation.navigation
            .tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }

}
