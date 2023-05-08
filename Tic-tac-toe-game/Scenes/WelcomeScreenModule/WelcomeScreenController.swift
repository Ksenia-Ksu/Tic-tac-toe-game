//
//  MainViewController.swift
//  Tic-tac-toe-game
//
//  Created by Ксения Кобак on 06.05.2023.
//

import UIKit

class WelcomeScreenController: UIViewController {
    
    var game = Game()
    
    lazy var pictures: UILabel = {
        let pictures = UILabel()
        pictures.font = .boldSystemFont(ofSize: 25)
        pictures.text = "❎❎❎"
        pictures.textAlignment = .center
        pictures.translatesAutoresizingMaskIntoConstraints = false
        return pictures
    }()
    
    lazy var greetingLabel: UILabel = {
        let greetingLabel = UILabel()
        greetingLabel.font = .systemFont(ofSize: 25)
        greetingLabel.text = "Welcome to Tic Tac Toe game!"
        greetingLabel.textAlignment = .center
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        return greetingLabel
    }()
    
    lazy var fieldsChoiseLabel: UILabel = {
        let fieldsChoiseLabel = UILabel()
        fieldsChoiseLabel.font = .systemFont(ofSize: 20)
        fieldsChoiseLabel.text = "Сhoose the size of the field from 3 to 7"
        fieldsChoiseLabel.textAlignment = .center
        fieldsChoiseLabel.numberOfLines = 2
        fieldsChoiseLabel.translatesAutoresizingMaskIntoConstraints = false
        return fieldsChoiseLabel
    }()
    
    lazy var fieldsCounter: UILabel = {
        let fieldsCounter = UILabel()
        fieldsCounter.font = .boldSystemFont(ofSize: 30)
        fieldsCounter.text = String(game.numberOfFields)
        fieldsCounter.translatesAutoresizingMaskIntoConstraints = false
        return fieldsCounter
    }()
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 3
        stepper.minimumValue = 3
        stepper.maximumValue = 7
        stepper.backgroundColor = .systemGreen
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
   
    lazy var startButton: UIButton = {
        let startButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGreen
        config.baseForegroundColor = .white
        var container = AttributeContainer()
        container.font = .boldSystemFont(ofSize: 20)
        config.attributedTitle = AttributedString("Start", attributes: container)
        startButton.configuration = config
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraits()
        startButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
    }
    
    
    @objc func startGameButtonTapped() {
        let gameVC = GameScreenAssembly.createModule(game)
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        let number = Int(sender.value)
        game.numberOfFields = number
        fieldsCounter.text = String(game.numberOfFields)
    }
    
    
    private func addSubviews() {
        view.addSubview(pictures)
        view.addSubview(greetingLabel)
        view.addSubview(fieldsChoiseLabel)
        view.addSubview(fieldsCounter)
        view.addSubview(stepper)
        view.addSubview(startButton)
    }
    
    private func addConstraits() {
        NSLayoutConstraint.activate([
            
            pictures.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pictures.bottomAnchor.constraint(equalTo: greetingLabel.topAnchor, constant: -30),
            
        
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.bottomAnchor.constraint(equalTo: fieldsChoiseLabel.topAnchor, constant: -30),

            fieldsChoiseLabel.bottomAnchor.constraint(equalTo: fieldsCounter.topAnchor, constant: -20),
            fieldsChoiseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           

            fieldsCounter.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            fieldsCounter.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
            stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepper.topAnchor.constraint(equalTo: fieldsCounter.bottomAnchor, constant: 20),

            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 40),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            
        ])
    }
}
