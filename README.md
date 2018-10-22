# SplittableViewKit

[![Language](http://img.shields.io/badge/Language-Swift-orange.svg?style=flat
)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/SplittableViewKit.svg?style=flat)](https://cocoapods.org/pods/SplittableViewKit)
[![License](https://img.shields.io/cocoapods/l/SplittableViewKit.svg?style=flat)](https://cocoapods.org/pods/SplittableViewKit)
[![Platform](https://img.shields.io/cocoapods/p/SplittableViewKit.svg?style=flat)](https://cocoapods.org/pods/SplittableViewKit)

A cell of `IndexPath(row: 0, section: 0)` in UITableView is automatically moved to left view when device rotated.

![](./Images/sample.gif)

## Usage

Please initialize `SplittableTableView` with initializer or Interface Builder.
`SplittableTableView.rightView` is UITableView.
Do not set delegate or dataSource directly to `SplittableTableView.rightView`.
You must use `SplittableTableView.delgate` or `SplittableTableView.dataSource`.

```swift
let splittableTableView: SplittableTableView

splittableTableView.delegate = self
splittableTableView.dataSource = self
splittableTableView.rightView.register(UINib(nibName: "ThumbnailViewCell", bundle: nil),
                                       forCellReuseIdentifier: "ThumbnailViewCell")
```

SplittableViewKit is almost same as UITableView interface because `SplittableTableViewDataSource` adopted UITableViewDataSource and `SplittableTableViewDelegate` adopted UITableViewDelegate.
`func splittableContainerViewFor(topView: UIView, layoutType: LayoutType) -> UIView` is only one difference.
You should return a UIView that layouted top view. Layout patterns are `LayoutType.left` and `LayoutType.fixedTop`.

```swift
extension ViewController: SplittableTableViewDataSource {
    func splittableContainerViewFor(topView: UIView, layoutType: LayoutType) -> UIView {
        let view = UIView(frame: .zero)
        topView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topView)
        if layoutType == .left {
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0),
                view.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0),
                view.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0)
            ])
        } else {
            NSLayoutConstraint.activate([
                view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0),
                view.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0),
                view.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0),
                view.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0)
            ])
        }
        return view
    }
}
```

| left | fixedTop |
| :-: | :-: |
| ![](./Images/normal.gif) | ![](./Images/fixed.gif) |

## Example

To run the example project, clone the repo, and run `pod install` from the `SplittableViewKitExample` directory first.

## Requirements

- iOS 9 or greater
- Swift 4 or greater

## Installation

SplittableViewKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SplittableViewKit'
```

## Author

marty-suzuki, s1180183@gmail.com

## License

SplittableViewKit is available under the MIT license. See the LICENSE file for more info.
