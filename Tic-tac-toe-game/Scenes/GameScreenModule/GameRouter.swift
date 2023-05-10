import UIKit

protocol GameRouting {
    func routeToAlert(title: String,
                      completionLeft: @escaping(() -> Void),
                      completionRight: @escaping(() -> Void)
    )
}

final class GameRouter: GameRouting {
    
    weak var viewController: UIViewController?
    
    func routeToAlert(title: String,
                      completionLeft: @escaping (() -> Void),
                      completionRight: @escaping(() -> Void)) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        let actionRestartLeft = UIAlertAction(title: GameScreenTextFor.Alert.restart,
                                              style: .cancel) { _ in
            completionLeft()
                                              }
        
        let actionNextRoundRight = UIAlertAction(title: GameScreenTextFor.Alert.nextRound,
                                                 style:  .default) { _ in
            completionRight()
                                                 }
        alert.addAction(actionRestartLeft)
        alert.addAction(actionNextRoundRight)
        viewController?.present(alert, animated: true)
    }
}
