# SwipeDownViewController

## Requirements

- iOS 10.0+
- Xcode 10.0+
- Swift 4.2+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To install it, simply add the following line to your Podfile:

```ruby
pod 'SwipeDownViewController'
```

#### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `SwipeDownViewController` by adding the proper description to your `Package.swift` file:

```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/allanscofield/SwipeDownViewController.git", from: "0.1.3"),
    ]
)
```
Then run `swift build` whenever you get prepared.

## Usage

### Showing a single ViewController with swipe down to dismiss

```swift

//OriginViewController

import UIKit
//1. Add a import
import SwipeDownViewController

//2. Inherit from SwipeDownOriginViewController
final class ViewController: SwipeDownOriginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showModal(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ModalViewController") as! SwipeDownViewController
        
        //3. Set delegates 
        vc.interactor = self.interactor
        vc.transitioningDelegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
}


//ModalViewController

import UIKit
//4. Add a import
import SwipeDownViewController

//5. Inherit from SwipeDownViewController
final class ModalViewController: SwipeDownViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

```

### Showing a ViewController embedded in a UINavigationController

```swift

//OriginViewController

import UIKit
//1. Add a import
import SwipeDownViewController

//2. Inherit from SwipeDownOriginViewController
final class ViewController: SwipeDownOriginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showModalWithNavigation(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ModalViewController")
        //3. Inherit from SwipeDownNavigationController
        let nav = SwipeDownNavigationController(with: vc, origin: self)
        self.present(nav, animated: true, completion: nil)
    }
}


//ModalViewController

import UIKit
import SwipeDownViewController

final class ModalViewController: SwipeDownViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

```

### Showing a ViewController embedded in a UINavigationController with a UITableView

```swift

//OriginViewController

import UIKit
//1. Add a import
import SwipeDownViewController

//2. Inherit from SwipeDownOriginViewController
final class ViewController: SwipeDownOriginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showModalWithNavigationAndTableView(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ModalTableViewController")
        //3. Inherit from SwipeDownNavigationController
        let nav = SwipeDownNavigationController(with: vc, origin: self)
        self.present(nav, animated: true, completion: nil)
    }
}


//ModalViewController

import UIKit
//4. Add a import
import SwipeDownViewController

//5. Inherit from SwipeDownViewController
final class ModalViewController: SwipeDownViewController {

    @IBOutlet weak private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //6. Add this line
        self.addSwipeDownToClose(to: self.tableView)
    }
}

```


## License

SwipeDownViewController is available under the MIT license. See the LICENSE file for more info.
