import UIKit

final class UserCell: UITableViewCell {
    // MARK: - Properties
    
    var viewModel: CardViewModel?
    
    // MARK: - Subviews
    
    private var cardView: CardView? {
        guard let viewModel = viewModel else {
            return nil
        }
        
        return CardView(with: viewModel)
    }
    
    // MARK: - Methods

    func setupView(with viewModel: CardViewModel){
        self.viewModel = viewModel
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        needsUpdateConstraints()
        setupContraints()
    }
  
    // MARK: - Private Methods

    private func setupContraints() {
        guard let cardView = cardView else {
            return
        }
        contentView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.base02),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.base08),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.base08),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.base02)
        ])
    }
}
