import UIKit

// Extensão para UIColor para suportar cores em hexadecimal
extension UIColor {
    
    static func customGray() -> UIColor {
        return UIColor(hex: "#272A2E")
    }
    static func customLightBlue() -> UIColor {
        return UIColor(hex: "#7FDBFF")
    }
    static func customLightGray() -> UIColor {
        return UIColor(hex: "#565656")
    }
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


