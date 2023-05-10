import UIKit

protocol WelcomeScreenRouting {
    func routeTogameScreen(_ numberOfFields: Int)
}

final class WelcomeScreenRouter: WelcomeScreenRouting {
    
    weak var viewController: UIViewController?
    
    func routeTogameScreen(_ numberOfFields: Int) {
        let gameVC = GameScreenAssembly.createModule(numberOfFields)
        viewController?.navigationController?.pushViewController(gameVC, animated: true)
    }
}
