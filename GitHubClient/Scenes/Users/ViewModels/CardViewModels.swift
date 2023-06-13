import UIKit

final class CardViewModel {
    // MARK: - Constants
    
    static let imagePlaceHolderName = "userPlaceHolder"
    
    // MARK: - Public Properties
    
    let placeHolder = UIImage(named: imagePlaceHolderName) ?? UIImage()
    var username: String {
        user.login
    }
    
    // MARK: - Private Properties
    
    private (set) var user: UserModel
    
    // MARK: - Initialization
    
    init(user: UserModel) {
        self.user = user
    }
    
    // MARK: - Public Methods
    
    func set(_ imageView: UIImageView) {
        ImageFetcher.shared.fetchImage(fromPhotoURL: user.avatarUrl,
                                       id: user.id,
                                       to: imageView)
    }
}


