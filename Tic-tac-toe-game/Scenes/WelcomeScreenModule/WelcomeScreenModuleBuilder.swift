import UIKit

protocol Builder {
    static func createModule() -> UIViewController
}

public struct WelcomeModuleBuilder: Builder {
    static func createModule() -> UIViewController {
        let presenter = WelcomeScreenPresenter()
        let interactor = WelcomeScreenInteractor(presenter: presenter)
        let router = WelcomeScreenRouter()
        let vc = WelcomeScreenViewController(interactor: interactor, router: router)
        presenter.viewController = vc
        router.viewController = vc
        return vc 
    }
}
