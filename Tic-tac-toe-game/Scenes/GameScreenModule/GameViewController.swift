
import UIKit

protocol DisplayGameViewLogic: AnyObject {
    func displayNewGame(_ viewModel: GameDataFlow.FetchGame.ViewModel)
    func displayWinner(_ viewModel: GameDataFlow.SelectCell.ViewModel)
    func displayTheEndGame()
    func displayNewField(_ viewModel: GameDataFlow.FetchGame.ViewModel)
}

final class GameViewController: UIViewController {
    
    var numberOfFields: Int
        
    private let interactor: GameBusinessLogic
    lazy var contentView: DisplayGameView = GameView(dataSource: self, delegate: self, numberOfCellsInRow: numberOfFields)
    var viewModelData: GameDataFlow.FetchGame.ViewModel?
    private var router: GameRouting
    
    init(interactor: GameBusinessLogic, router: GameRouting, numberOfFields: Int ) {
        self.numberOfFields = numberOfFields
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.startGame(.init(numberOfFields: numberOfFields))
    }
    
    
    //MARK: - Actions
    
    @objc func buttonTapped(sender: UIButton) {
        changeButtonTitle(sender: sender, title: (viewModelData?.gameViewModel.currentPlayer)!)
        interactor.playerDidMove(.init(cellIndex: sender.tag,
                                       title: sender.title(for: .normal)))
        sender.isEnabled = false
        
    }
    
    private func changeButtonTitle(sender: UIButton, title: String) {
            var config = UIButton.Configuration.plain()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 50)
            container.foregroundColor = .white
            config.attributedTitle = AttributedString(title, attributes: container)
            config.background.backgroundColor = .systemGreen
            sender.configuration = config
    }
    
    private func backToMainScreen() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}



//MARK: - CollectionView DataSourse and Delegate

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfFields * numberOfFields
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        cell.button.tag = indexPath.row
        cell.reloadButtonText()
        cell.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return cell
    }
}


extension GameViewController: DisplayGameViewLogic {
    
    func displayNewGame(_ viewModel: GameDataFlow.FetchGame.ViewModel) {
        self.viewModelData = viewModel
        contentView.configure(with: .init(gameViewModel: viewModel.gameViewModel))
        contentView.reloadCollectionView()
    }
    
    func displayNewField(_ viewModel: GameDataFlow.FetchGame.ViewModel) {
        viewModelData = viewModel
        contentView.configure(with: .init(gameViewModel: viewModel.gameViewModel))
    }
    
    func displayWinner(_ viewModel: GameDataFlow.SelectCell.ViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.router.routeToAlert(title: "\(GameScreenTextFor.Alert.winner)" + "\(viewModel.gameViewModel)") {
                self.backToMainScreen()
            } completionRight: {
                self.interactor.startGame(.init(numberOfFields: self.numberOfFields))
            }
        }
    }
    
    func displayTheEndGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.router.routeToAlert(title: GameScreenTextFor.Alert.noWinner) {
                self.backToMainScreen()
            } completionRight: {
                self.interactor.startGame(.init(numberOfFields: self.numberOfFields))
                self.contentView.reloadCollectionView()
            }
        }
    }
}

