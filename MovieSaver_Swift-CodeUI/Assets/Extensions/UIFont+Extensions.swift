
import UIKit.UIFont

enum FontStyle: String {
    case bold = "Manrope-Bold"
    case extraBold = "Manrope-ExtraBold"
    case extraLight = "Manrope-ExtraLight"
    case light = "Manrope-Light"
    case medium = "Manrope-Medium"
    case regular = "Manrope-Regular"
    case semiBold = "Manrope-SemiBold"
}

extension UIFont {
    static func manrope(ofSize size: CGFloat, style: FontStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
