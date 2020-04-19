import UIKit

open class SplitTabBarViewController: UISplitViewController {
    public let masterNavigation: SplitTabBarMasterNavigationController
    public let detailTabBar: SplitTabBarDetailController

    public var compactPreferredDisplayMode = UISplitViewController.DisplayMode.primaryHidden
    public var regularPreferredDisplayMode = UISplitViewController.DisplayMode.automatic

    public var shouldHideTabBar: Bool = true {
        didSet {
            if !shouldHideTabBar {
                self.detailTabBar.tabBar.isHidden = false
            }
            self.setSplitTabs()
        }
    }

    public init(
        masterNavigation: SplitTabBarMasterNavigationController,
        detailTabBar: SplitTabBarDetailController
    ) {
        self.masterNavigation = masterNavigation
        self.detailTabBar = detailTabBar
        super.init(nibName: nil, bundle: nil)
    }

    public convenience init(viewControllers: [UIViewController]? = nil) {
        self.init(
            masterNavigation: SplitTabBarMasterNavigationController(),
            detailTabBar: SplitTabBarDetailController())
        self.setViewControllers(viewControllers)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setViewControllers(_ viewControllers: [UIViewController]?) {
        self.detailTabBar.viewControllers = viewControllers
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.latestTraitCollection = self.traitCollection

        NotificationCenter.default.addObserver(
            self, selector: #selector(deviceOrientationDidChangeNotification),
            name: UIDevice.orientationDidChangeNotification, object: nil)
        
        self.delegate = self

        self.viewControllers = [masterNavigation, detailTabBar]

        //self.preferredDisplayMode = .allVisible

        self.setSplitTabs()
        // Do any additional setup after loading the view.
    }

    public private(set) var latestTraitCollection: UITraitCollection?

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.latestTraitCollection = self.traitCollection
        self.setSplitTabs()
    }

    open override func willTransition(
        to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator
    ) {
        self.latestTraitCollection = newCollection
        super.willTransition(to: newCollection, with: coordinator)
    }

    open func setSplitTabs() {
        if self.traitCollection.horizontalSizeClass == .compact {
            self.preferredDisplayMode = self.compactPreferredDisplayMode
            if self.shouldHideTabBar {
                self.detailTabBar.tabBar.isHidden = false
            }
        } else {
            self.preferredDisplayMode = self.regularPreferredDisplayMode
            if self.shouldHideTabBar {
                self.detailTabBar.tabBar.isHidden = true
            }
        }
    }

    @objc func deviceOrientationDidChangeNotification(_ notification: Any) {
        self.setSplitTabs()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setSplitTabs()
    }
}

extension SplitTabBarViewController: UISplitViewControllerDelegate {
    open func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        return true
    }

    open func primaryViewController(forCollapsing splitViewController: UISplitViewController)
        -> UIViewController?
    {
        if self.latestTraitCollection?.horizontalSizeClass == .compact {
            return detailTabBar
        }
        return masterNavigation
    }

    open func primaryViewController(forExpanding splitViewController: UISplitViewController)
        -> UIViewController?
    {
        if self.latestTraitCollection?.horizontalSizeClass == .compact {
            return detailTabBar
        }

        return masterNavigation
    }
}
