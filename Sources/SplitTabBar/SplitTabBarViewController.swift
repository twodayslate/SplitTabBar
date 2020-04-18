import UIKit

open class SplitTabBarViewController: UISplitViewController {
    public let masterNavigation = SplitTabBarMasterNavigationController()
    public let detailTabBar = SplitTabBarDetailController()
    
    public var compactPreferredDisplayMode = UISplitViewController.DisplayMode.primaryHidden
    public var regularPreferredDisplayMode = UISplitViewController.DisplayMode.automatic
    
    public var hideTabBar: Bool = true
    
    public init(viewControllers: [UIViewController]? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers(viewControllers)
    }
    
    public func setViewControllers(_ viewControllers: [UIViewController]?) {
        self.detailTabBar.viewControllers = viewControllers
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.latestTraitCollection = self.traitCollection
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChangeNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        self.delegate = self
        
        self.viewControllers = [masterNavigation, detailTabBar]
    
        //self.preferredDisplayMode = .allVisible
        
        self.setSplitTabs()
        // Do any additional setup after loading the view.
    }
    
    var latestTraitCollection: UITraitCollection?
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.latestTraitCollection = self.traitCollection
        self.setSplitTabs()
    }
    
    open override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.latestTraitCollection = newCollection
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    open func setSplitTabs() {
        if self.traitCollection.horizontalSizeClass == .compact {
            self.preferredDisplayMode = self.compactPreferredDisplayMode
            if self.hideTabBar {
                self.detailTabBar.tabBar.isHidden = false
            }
        } else {
            self.preferredDisplayMode = self.regularPreferredDisplayMode
            if self.hideTabBar {
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
    public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

    public func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        if self.latestTraitCollection?.horizontalSizeClass == .compact {
            return detailTabBar
        }
        return masterNavigation
    }
    
    public func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        if self.latestTraitCollection?.horizontalSizeClass == .compact {
            return detailTabBar
        }

        return masterNavigation
    }
}
