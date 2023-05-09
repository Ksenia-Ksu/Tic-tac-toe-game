
import Foundation

protocol WelcomeScreenBusinessLogic {
    func updateSizePlayingField(_ request: DataFlowWelcome.Request)
}


final class WelcomeScreenInteractor: WelcomeScreenBusinessLogic {
       
    let presenter: WelcomePresentationLogic
    
    init(presenter: WelcomePresentationLogic) {
        self.presenter = presenter
    }
    
    func updateSizePlayingField(_ request: DataFlowWelcome.Request) {
        presenter.presentSizeOfField(.init(numberFields: request.numberOfFields))
    }
}
