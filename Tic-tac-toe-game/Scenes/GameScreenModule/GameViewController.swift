//
//  ViewController.swift
//  Tic-tac-toe-game
//
//  Created by Ксения Кобак on 06.05.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    //var presenter: GameViewPresenterProtocol?
    var moves = 0
    
    var game: Game
    
    init(game: Game) {
       // self.presenter = presenter
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.size.width/CGFloat(game.numberOfFields)) - 15,
                                 height: (view.frame.size.width/CGFloat(game.numberOfFields)) - 15)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 15
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
        whoseTurn.text = game.currentTurn.rawValue
        whoseTurn.translatesAutoresizingMaskIntoConstraints = false
        return whoseTurn
    }()
    
    
    lazy var containerForScoresLabel: UIStackView = {
        let containerForScoresLabel = UIStackView()
        containerForScoresLabel.axis = .horizontal
        containerForScoresLabel.distribution = .fillEqually
        containerForScoresLabel.spacing = 20
        containerForScoresLabel.translatesAutoresizingMaskIntoConstraints = false
        return containerForScoresLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraits()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .white
        game.createGame()
        
    }
    
    //MARK: - setUp Views
    
    private func addSubviews() {
        view.addSubview(turnLabel)
        view.addSubview(whoseTurn)
        view.addSubview(containerForScoresLabel)
        view.addSubview(collectionView)
    }
    
    private func addConstraits() {
        NSLayoutConstraint.activate([
            turnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            turnLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            
            whoseTurn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whoseTurn.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: 15),
            
            containerForScoresLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            containerForScoresLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            containerForScoresLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            containerForScoresLabel.heightAnchor.constraint(equalToConstant: 80),
            
            collectionView.topAnchor.constraint(equalTo: whoseTurn.bottomAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),        collectionView.bottomAnchor.constraint(equalTo: containerForScoresLabel.topAnchor, constant: -10)
        ])
    }
    
    
    
    //MARK: - Actions
    
    @objc func buttonTapped(sender: UIButton) {
        moveDone(sender)
        if checkingWinner(sender.tag) {
            let winner = game.currentTurn == Turn.O ? Turn.X.rawValue : Turn.O.rawValue
            alertWithResultGame(title: "The winner is \(winner)")
        } else if  moves == game.numberOfFields * game.numberOfFields && !checkingWinner(sender.tag) {
            alertWithResultGame(title: "There is no winner... Try again?")
        }
        
    }
    
    private func moveDone(_ sender: UIButton) {
        moves += 1
        if(sender.title(for: .normal)) == nil {
            if game.currentTurn == Turn.O {
                changeConfuguration(button: sender, title: Turn.O.rawValue)
                game.currentTurn = Turn.X
                whoseTurn.text = Turn.X.rawValue
            } else if game.currentTurn == Turn.X {
                changeConfuguration(button: sender, title: Turn.X.rawValue)
                game.currentTurn = Turn.O
                whoseTurn.text = Turn.O.rawValue
            }
            sender.isEnabled = false
          
        }
    }
    
    private func checkingWinner(_ field: Int) -> Bool {
        var row = 0
        var column = 0
        if field < game.numberOfFields {
            column = field
        } else {
            row = (field) / game.numberOfFields
            column = (field) % game.numberOfFields
        }
        return game.isWinner(row, column, motion: game.currentTurn.rawValue)
    }
    
    
    private func changeConfuguration(button: UIButton, title: String) {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = .boldSystemFont(ofSize: 30)
        container.foregroundColor = .white
        config.attributedTitle = AttributedString(title, attributes: container)
        config.background.backgroundColor = .systemGreen
        button.configuration = config
    }
    
    private func alertWithResultGame(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let actionReset = UIAlertAction(title: "Restart", style: .cancel) { _ in
            self.backToMainScreen()
        }
        let actionNextRound = UIAlertAction(title: "NextRound", style: .default) { _ in
            self.playNextRound()
        }
        alert.addAction(actionReset)
        alert.addAction(actionNextRound)
        self.present(alert, animated: true)
    }
    
    private func backToMainScreen() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func playNextRound() {
        game.createGame()
        moves = 0
        game.currentTurn = Turn.X
        whoseTurn.text = Turn.X.rawValue
        collectionView.reloadData()
    }
}





extension GameViewController: GameViewProtocol {
    func nextRound() {
        print("next round tap")
    }
    
    func restartGame() {
        print("restsrt tap")
    }
    
    
}
//MARK: - CollectionView DataSourse and Delegate

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        game.numberOfFields * game.numberOfFields
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GameCollectionViewCell
        cell.button.tag = indexPath.row
        
        // надо как то очистить поле
        cell.reloadButtonText()
        cell.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return cell
    }
}


