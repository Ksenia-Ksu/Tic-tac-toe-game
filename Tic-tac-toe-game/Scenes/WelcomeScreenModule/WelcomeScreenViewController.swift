import UIKit

protocol WelcomeScreenViewControllerDisplayLogic: AnyObject {
    func displaySizeOfPlayingField(_ viewModel: DataFlowWelcome.ViewModel)
}

final class WelcomeScreenViewController: UIViewController {
    
    private let interactor: WelcomeScreenBusinessLogic
    private let router: WelcomeScreenRouting
    lazy var contentView: DisplaysView = WelcomeScreenView(delegate: self)
    var numberOfFields = 3
    
    override func loadView() {
        view = contentView
    }
    
    init(interactor: WelcomeScreenBusinessLogic, router: WelcomeScreenRouting ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WelcomeScreenViewController: ViewDelegate {
   
    func changeFieldsCounter(value: Double) {
        numberOfFields = Int(value)
        interactor.updateSizePlayingField(.init(numberOfFields: value))
    }
    
    func startGamebuttonTapped() {
        router.routeTogameScreen(numberOfFields)
    }
}

extension WelcomeScreenViewController: WelcomeScreenViewControllerDisplayLogic {
    
    func displaySizeOfPlayingField(_ viewModel: DataFlowWelcome.ViewModel) {
        contentView.configure(with: viewModel)
    }
}
