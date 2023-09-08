// A platform agnostic color type

#if canImport(UIKit)
import UIKit
public typealias AgnosticColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias AgnosticColor = NSColor
#endif

public extension AgnosticColor {
    func rgbColor() -> RGBColor? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &alpha)
        return RGBColor(r: r, g: g, b: b, alpha: alpha)
    }
}
