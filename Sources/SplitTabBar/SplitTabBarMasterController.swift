import UIKit

open class SplitTabBarMasterController: UITableViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Navigation"
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.viewControllers?.count ?? 0
    }
        
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = (self.splitViewController as?
            SplitTabBarViewController)?.detailTabBar.viewControllers?[indexPath.row].title
        
        
        if let row = (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.selectedViewControllerIndex {
            
            let selectedIndexPath = IndexPath(row: row, section: 0)
            tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
            
            if indexPath == selectedIndexPath {
                cell.imageView?.image = (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.viewControllers?[indexPath.row].tabBarItem.selectedImage
            } else {
                cell.imageView?.image = (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.viewControllers?[indexPath.row].tabBarItem.image
            }
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.selectedIndex = indexPath.row
        
        tableView.cellForRow(at: indexPath)?.imageView?.image = (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.viewControllers?[indexPath.row].tabBarItem.selectedImage
    }
    
    override public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.imageView?.image = (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.viewControllers?[indexPath.row].tabBarItem.image
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let index = (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.selectedViewControllerIndex else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        
        self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
        self.tableView.selectRow(at: indexPath, animated: animated, scrollPosition: .none)
        // since the above doesn't always refresh the cell, we do it here
        //self.tableView.cellForRow(at: indexPath)?.imageView?.image = (self.splitViewController as? SplitTabBarViewController)?.detailTabBar.viewControllers?[indexPath.row].tabBarItem.selectedImage
    }
}
