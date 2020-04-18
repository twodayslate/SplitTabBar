# SplitTabBar

A UISplitViewController combined with a UITabBarController

<p align="center">
<img src="https://raw.githubusercontent.com/twodayslate/SplitTabBar/master/Example/macos.png" width="50%" alt="macOS Screenshot"/>
</p>

## Usage

```swift
import SplitTabBar

let splitTabBar = SplitTabBarViewController(viewControllers: [/*view controllers here*/])
splitTabBar.hideTabBar = false
```

The navigatable view controllers are controlled via the tab bar detail view controller. You can modify them like so:
```swift
splitTabBar.detailTabBar.viewControllers = [/*your new view controllers */]
```
