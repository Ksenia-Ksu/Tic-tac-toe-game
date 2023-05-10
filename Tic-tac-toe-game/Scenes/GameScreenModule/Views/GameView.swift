import UIKit

protocol DisplayGameView: UIView {
    func configure(with viewModel: GameDataFlow.FetchGame.ViewModel)
    func reloadCollectionView()
}

protocol GameViewDelegate: AnyObject {
    func cellIsSelected(at tag: Int)
}

final class GameView: UIView {
    
    var numberOfCellsInRow = 3
    
    private weak var delagate: GameViewDelegate?
        
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 15
        let itemsCount = CGFloat(numberOfCellsInRow)
        let paddingCount = itemsCount + 1
        let paddingSize = paddingCount * padding
        let cellSize = (ScreenSize.width - paddingSize) / itemsCount
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "GameCollectionViewCell")
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
            turnLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: Layout.GameScreen.offset),
            
            whoseTurn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            whoseTurn.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: Layout.GameScreen.offset),
            
            collectionView.topAnchor.constraint(equalTo: whoseTurn.bottomAnchor, constant: Layout.GameScreen.offset),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 0)
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
