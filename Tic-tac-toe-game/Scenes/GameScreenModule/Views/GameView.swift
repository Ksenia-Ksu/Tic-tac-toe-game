
import UIKit

protocol DisplayGameView: UIView {
    func configure(with viewModel: GameDataFlow.FetchGame.ViewModel)
    func reloadCollectionView()
}

protocol GameViewDelegate: AnyObject {
    func cellIsSelected(at tag: Int)
}

final class GameView: UIView {
    
    var numberOfCellsInRow: Int?
    
    private weak var delagate: GameViewDelegate?
        
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 15
        let size = numberOfCellsInRow ?? 3
        let width = ScreenSize.width/CGFloat(size) - 15
        let heigh = ScreenSize.width/CGFloat(size) - 15
        layout.itemSize = CGSize(width: width, height: heigh)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var turnLabel: UILabel = {
        let turnLabel = UILabel()
        turnLabel.font = .boldSystemFont(ofSize: 25)
        turnLabel.text = "TURN"
        turnLabel.translatesAutoresizingMaskIntoConstraints = false
        return turnLabel
    }()
    
    lazy var whoseTurn: UILabel = {
        let whoseTurn = UILabel()
        whoseTurn.font = .boldSystemFont(ofSize: 30)
        whoseTurn.translatesAutoresizingMaskIntoConstraints = false
        return whoseTurn
    }()
    
    
    required init(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate, numberOfCellsInRow: Int) {
        super.init(frame: .zero)
        self.numberOfCellsInRow = numberOfCellsInRow
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        self.backgroundColor = .white
        addSubviews()
        addConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(turnLabel)
        self.addSubview(whoseTurn)
        self.addSubview(collectionView)
    }
    
    private func addConstraits() {
        NSLayoutConstraint.activate([
            turnLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            turnLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 15),
            
            whoseTurn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            whoseTurn.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: 15),
            
            collectionView.topAnchor.constraint(equalTo: whoseTurn.bottomAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),        collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -10)
        ])
    }
    
}

extension GameView: DisplayGameView {
   
    func configure(with viewModel: GameDataFlow.FetchGame.ViewModel) {
        whoseTurn.text = viewModel.gameViewModel.currentPlayer
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}