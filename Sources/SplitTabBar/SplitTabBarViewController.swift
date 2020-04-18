import UIKit

class SplitTabBarViewController: UISplitViewController {
    let masterNavigation = SplitTabBarMasterNavigationController()
    let detailTabBar = SplitTabBarDetailController()
    
    var compactPreferredDisplayMode = UISplitViewController.DisplayMode.primaryHidden
    var regularPreferredDisplayMode = UISplitViewController.DisplayMode.automatic
    
    var hideTabBar: Bool = true
    
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.detailTabBar.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.latestTraitCollection = self.traitCollection
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.latestTraitCollection = newCollection
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    func setSplitTabs() {
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
    
    override func viewDidAppear(_ animated: Bool) {
        setSplitTabs()
    }
}

extension SplitTabBarViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        if self.latestTraitCollection?.horizontalSizeClass == .compact {
            return detailTabBar
        }
        return masterNavigation
    }
    
    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        if self.latestTraitCollection?.horizontalSizeClass == .compact {
            return detailTabBar
        }

        return masterNavigation
    }
}
