
import Foundation

protocol WelcomePresentationLogic: AnyObject {
    func presentSizeOfField(_ response: DataFlowWelcome.Response)
}

final class WelcomeScreenPresenter {
    
    weak var viewController: WelcomeScreenViewControllerDisplayLogic?
    
}

extension WelcomeScreenPresenter: WelcomePresentationLogic {
    
    func presentSizeOfField(_ response: DataFlowWelcome.Response) {
        let title = String(Int(response.numberFields))
        viewController?.displaySizeOfPlayingField(.init(title: title))
    }
}


