
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
    
    lazy var pictures: UILabel = {
        let pictures = UILabel()
        pictures.font = .boldSystemFont(ofSize: 25)
        pictures.text = WelcomeScreenTextFor.picturesLabel
        pictures.textAlignment = .center
        pictures.translatesAutoresizingMaskIntoConstraints = false
        return pictures
    }()
    
    lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.font = .systemFont(ofSize: 25)
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
        fieldsCounter.font = .boldSystemFont(ofSize: 30)
        fieldsCounter.text = WelcomeScreenTextFor.fieldsCounterLabel
        fieldsCounter.translatesAutoresizingMaskIntoConstraints = false
        return fieldsCounter
    }()
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 3
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
        container.font = .boldSystemFont(ofSize: 20)
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
        self.addSubview(pictures)
        self.addSubview(welcomeLabel)
        self.addSubview(fieldsChoiseLabel)
        self.addSubview(fieldsCounter)
        self.addSubview(stepper)
        self.addSubview(startButton)
    }
    
    
    private func addConstraits() {
        NSLayoutConstraint.activate([
            
            pictures.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pictures.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: -30),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            welcomeLabel.bottomAnchor.constraint(equalTo: fieldsChoiseLabel.topAnchor, constant: -30),

            fieldsChoiseLabel.bottomAnchor.constraint(equalTo: fieldsCounter.topAnchor, constant: -20),
            fieldsChoiseLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
           
            fieldsCounter.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            fieldsCounter.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            stepper.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stepper.topAnchor.constraint(equalTo: fieldsCounter.bottomAnchor, constant: 20),

            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: 40),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension WelcomeScreenView: DisplaysView {
    
    func configure(with viewModel: DataFlowWelcome.ViewModel) {
        fieldsCounter.text = viewModel.title
    }
}
