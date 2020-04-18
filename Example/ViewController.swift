import UIKit



class NumberedNavigationController: UINavigationController {
    init(_ number: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = [NamedController("\(number)")]
        
        self.title = "\(number)"
        
        if #available(iOS 13.0, *) {
            self.tabBarItem.image = UIImage(systemName: "\(number).circle")
            self.tabBarItem.selectedImage = UIImage(systemName: "\(number).circle.fill")
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NamedController: UIViewController {
    var name: String? {
        didSet {
            self.title = name
            self.view.setNeedsLayout()
        }
    }
    
    init(_ name: String?) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
        
        self.tabBarItem = UITabBarItem(title: name, image: nil, selectedImage: nil)
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        self.title = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = self.name?.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.navigationItem.leftBarButtonItem =
            splitViewController?.displayModeButtonItem
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}


extension UIUserInterfaceSizeClass: CustomStringConvertible {
    public var description: String {
        switch self {
        case .compact: return "compact"
        case .regular: return "regular"
        case .unspecified: return "unspecified"
        @unknown default:
            return "unknown"
        }
    }
}

extension UIDeviceOrientation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .portrait: return "portrait"
        case .faceDown: return "faceDown"
        case .faceUp: return "faceUp"
        case .landscapeLeft: return "landscapeLeft"
        case .landscapeRight: return "landscapeRight"
        case .portraitUpsideDown: return "portraitUpsideDown"
        default: return "unknown"
        }
    }
}
