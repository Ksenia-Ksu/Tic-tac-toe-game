
import UIKit

private let reuseIdentifier = "Cell"

final class GameCollectionViewCell: UICollectionViewCell {
    
    
    let button: UIButton = {
        var button = UIButton()
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = .boldSystemFont(ofSize: 30)
        config.attributedTitle = AttributedString("", attributes: container)
        config.background.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = config
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
       
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
        ])
    }
    
    func reloadButtonText() {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = .boldSystemFont(ofSize: 30)
        config.attributedTitle = AttributedString("", attributes: container)
        config.background.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = config
        button.isEnabled = true
    }
}
