import UIKit

class BaseViewController: UIViewController {
    var spinner = UIActivityIndicatorView()
}

extension BaseViewController {
    func setupLargeCentralSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        self.spinner = spinner
    }
    
    func showAlert(with title: String, message: String, andButtonTitle buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
