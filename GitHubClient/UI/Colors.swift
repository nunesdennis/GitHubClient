import UIKit

extension UIColor {
    static var skyBlue: UIColor {
        Colors.skyBlue.uiColor()
    }
    
    static var lightSkyBlue: UIColor {
        Colors.lightSkyBlue.uiColor()
    }
    
    static var paleTurquoise: UIColor {
        Colors.paleTurquoise.uiColor()
    }
}

private enum Colors: String {
    case skyBlue = "#82D1F1ff"
    case lightSkyBlue = "#ACE7F8ff"
    case paleTurquoise = "#CBF3F9ff"
    
    func uiColor() -> UIColor {
        return UIColor(hex: self.rawValue) ?? .red
    }
}
