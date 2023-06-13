import UIKit

final class CardView: UIView {
    // MARK: - Properties
    
    var viewModel: CardViewModel
    
    // MARK: - Subviews
    
    private lazy var avatarImage: UIImageView = {
        let imgView = UIImageView()
        imgView.sizeToFit()
        imgView.layer.cornerRadius = 16
        imgView.layer.masksToBounds = true
        imgView.clipsToBounds = true
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.darkGray.cgColor
        imgView.image = viewModel.placeHolder
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.username
        label.textColor = .darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImage, usernameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Space.base10
        stackView.axis = .horizontal
        stackView.alignment = .leading
        
        return stackView
    }()

    // MARK: - Initialization

    init(with viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        backgroundColor = .lightSkyBlue
        viewModel.set(avatarImage)
    }
    
    private func setupContraints() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalToConstant: Space.base30),
            avatarImage.widthAnchor.constraint(equalToConstant: Space.base30)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.heightAnchor.constraint(equalToConstant: Space.base30)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

