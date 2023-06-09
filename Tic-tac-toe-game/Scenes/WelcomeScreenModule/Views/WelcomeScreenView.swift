import UIKit

protocol DisplaysView: UIView {
    func configure(with viewModel: DataFlowWelcome.ViewModel)
}

protocol ViewDelegate: AnyObject {
    func changeFieldsCounter(value: Double)
    func startGamebuttonTapped()
}

final class WelcomeScreenView: UIView {
    
    private weak var delegate: ViewDelegate?
    
    lazy var picturesRowOne: UILabel = {
        let picturesRowOne = UILabel()
        picturesRowOne.font = .boldSystemFont(ofSize: 35)
        picturesRowOne.text = WelcomeScreenTextFor.firstRowPicturesLabel
        picturesRowOne.textAlignment = .center
        picturesRowOne.translatesAutoresizingMaskIntoConstraints = false
        return picturesRowOne
    }()
    
    lazy var picturesRowTwo: UILabel = {
        let picturesRowTwo = UILabel()
        picturesRowTwo.font = .boldSystemFont(ofSize: 35)
        picturesRowTwo.text = WelcomeScreenTextFor.secondRowPicturesLabel
        picturesRowTwo.textAlignment = .center
        picturesRowTwo.translatesAutoresizingMaskIntoConstraints = false
        return picturesRowTwo
    }()
    
    lazy var picturesRowThree: UILabel = {
        let picturesRowThree = UILabel()
        picturesRowThree.font = .boldSystemFont(ofSize: 35)
        picturesRowThree.text = WelcomeScreenTextFor.thirdRowPicturesLabel
        picturesRowThree.textAlignment = .center
        picturesRowThree.translatesAutoresizingMaskIntoConstraints = false
        return picturesRowThree
    }()
    
    lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.font = .boldSystemFont(ofSize: 25)
        welcomeLabel.text = WelcomeScreenTextFor.welcomeLabel
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        return welcomeLabel
    }()
    
    lazy var fieldsChoiseLabel: UILabel = {
        let fieldsChoiseLabel = UILabel()
        fieldsChoiseLabel.font = .systemFont(ofSize: 20)
        fieldsChoiseLabel.text = WelcomeScreenTextFor.fieldsChoiseLabel
        fieldsChoiseLabel.textAlignment =  .center
        fieldsChoiseLabel.translatesAutoresizingMaskIntoConstraints = false
        return fieldsChoiseLabel
    }()
    
    lazy var fieldsCounter: UILabel = {
        let fieldsCounter = UILabel()
        fieldsCounter.font = .boldSystemFont(ofSize: 35)
        fieldsCounter.text = WelcomeScreenTextFor.fieldsCounterLabel
        fieldsCounter.translatesAutoresizingMaskIntoConstraints = false
        return fieldsCounter
    }()
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = WelcomeScreenTextFor.stepperMinValue
        stepper.minimumValue = WelcomeScreenTextFor.stepperMinValue
        stepper.maximumValue = WelcomeScreenTextFor.stepperMaxValue
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
        container.font = .boldSystemFont(ofSize: 30)
        config.attributedTitle = AttributedString(WelcomeScreenTextFor.startButton, attributes: container)
        startButton.configuration = config
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    required init(delegate: ViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        addSubviews()
        addConstraits()
        self.backgroundColor = .white
        startButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        stepper.addTarget(self, action: #selector(stepperChanged(sender: )), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func startGameButtonTapped() {
        delegate?.startGamebuttonTapped()
    }
    
    @objc func stepperChanged(sender: UIStepper) {
        delegate?.changeFieldsCounter(value: sender.value)
    }
    
    private func addSubviews() {
        self.addSubview(picturesRowOne)
        self.addSubview(picturesRowTwo)
        self.addSubview(picturesRowThree)
        self.addSubview(welcomeLabel)
        self.addSubview(fieldsChoiseLabel)
        self.addSubview(fieldsCounter)
        self.addSubview(stepper)
        self.addSubview(startButton)
    }
    
    private func addConstraits() {
        NSLayoutConstraint.activate([
            picturesRowOne.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            picturesRowOne.bottomAnchor.constraint(equalTo: picturesRowTwo.topAnchor, constant: 0),
            
            picturesRowTwo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            picturesRowTwo.bottomAnchor.constraint(equalTo: picturesRowThree.topAnchor, constant: 0),
            
            picturesRowThree.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            picturesRowThree.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: -Layout.WelcomeScreen.offset),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            welcomeLabel.bottomAnchor.constraint(equalTo: fieldsChoiseLabel.topAnchor, constant: -Layout.WelcomeScreen.offset),

            fieldsChoiseLabel.bottomAnchor.constraint(equalTo: fieldsCounter.topAnchor, constant: -Layout.WelcomeScreen.offset),
            fieldsChoiseLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           
            fieldsCounter.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            fieldsCounter.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            stepper.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stepper.topAnchor.constraint(equalTo: fieldsCounter.bottomAnchor, constant: Layout.WelcomeScreen.offset),

            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: Layout.WelcomeScreen.offset),
            startButton.heightAnchor.constraint(equalToConstant: Layout.WelcomeScreen.startButtonHeigh),
            startButton.widthAnchor.constraint(equalToConstant: Layout.WelcomeScreen.startButtonWidth),
        ])
    }
}

extension WelcomeScreenView: DisplaysView {
    
    func configure(with viewModel: DataFlowWelcome.ViewModel) {
        fieldsCounter.text = viewModel.title
    }
}
