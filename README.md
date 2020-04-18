# SplitTabBar

A `UISplitViewController` combined with a `UITabBarController` in sync

<p align="center">
<img src="https://raw.githubusercontent.com/twodayslate/SplitTabBar/master/Example/macos.png" width="50%" alt="macOS Screenshot"/><img src="https://raw.githubusercontent.com/twodayslate/SplitTabBar/master/Example/iPad.png" width="50%" alt="iPad Screenshot"/>
</p>

## Usage

```swift
import SplitTabBar

let splitTabBar = SplitTabBarViewController(viewControllers: [/*view controllers here*/])
```

The navigatable view controllers are controlled via the tab bar detail view controller. You can modify them like so:
```swift
splitTabBar.setViewControllers([/*your new view controllers */])
// or
splitTabBar.detailTabBar.viewControllers = [/*your new view controllers */]
```

If you want the `UITabBarController` tabs to always be present you can enable them via
```swift
splitTabBar.hideTabBar = false
```
You can see an example of showing both the `UISplitViewController` navigation and the `UITabBarController` tabs in the [macOS screenshots above](https://raw.githubusercontent.com/twodayslate/SplitTabBar/master/Example/macos.png).

By default the `SplitTabBarViewController` will hide the `UISplitViewController` and just display the `UITabBarController` when its `traitCollection` `horizontalSizeClass` is `compact`.  You can change this behavior using the following properties:
```swift
splitTabBar.compactPreferredDisplayMode = UISplitViewController.DisplayMode.primaryHidden
splitTabBar.regularPreferredDisplayMode = UISplitViewController.DisplayMode.automatic
```
