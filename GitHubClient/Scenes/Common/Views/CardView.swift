import UIKit

final class CardView: UIView {
    // MARK: - Constants
    
    let cornerRadius: CGFloat = 16
    
    // MARK: - Properties
    
    var viewModel: CardViewModel
    let isFullSize: Bool
    
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
        let fontSize = isFullSize ? Space.base15 : Space.base10
        let label = UILabel()
        label.text = viewModel.username
        label.textColor = .darkGray
        label.textAlignment = textAlignment
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImage, usernameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Space.base10
        stackView.axis = stackViewAlix
        stackView.alignment = stackViewAlignment
        
        return stackView
    }()
    
    private var textAlignment: NSTextAlignment {
        isFullSize ? .center : .left
    }
    
    private var stackViewAlix: NSLayoutConstraint.Axis {
        isFullSize ? .vertical : .horizontal
    }
    
    private var stackViewAlignment: UIStackView.Alignment {
        isFullSize ? .center : .leading
    }

    // MARK: - Initialization

    init(with viewModel: CardViewModel, isFullSize: Bool = false) {
        self.viewModel = viewModel
        self.isFullSize = isFullSize
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
        viewModel.set(avatarImage)
        if !isFullSize {
            backgroundColor = .lightSkyBlue
            layer.cornerRadius = cornerRadius
        }
    }
    
    private func setupContraints() {
        addSubview(stackView)
        
        let avatarImgSize = isFullSize ? Space.base50 : Space.base30
        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalToConstant: avatarImgSize),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarImgSize)
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

