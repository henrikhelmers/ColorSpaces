import Foundation

/// Values ranged 0—1
public struct RGBColor {
    public let r: CGFloat
    public let g: CGFloat
    public let b: CGFloat
    public let alpha: CGFloat

    public init (r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, alpha: CGFloat = 1) {
        self.r = r
        self.g = g
        self.b = b
        self.alpha = alpha
    }

    fileprivate func sRGBCompand(_ v: CGFloat) -> CGFloat {
        let absV = abs(v)
        let out = absV > 0.04045 ? pow((absV + 0.055) / 1.055, 2.4) : absV / 12.92
        return v > 0 ? out : -out
    }

    public func toXYZ() -> XYZColor {
        let R = sRGBCompand(r)
        let G = sRGBCompand(g)
        let B = sRGBCompand(b)
        let x: CGFloat = (R * 0.4124564) + (G * 0.3575761) + (B * 0.1804375)
        let y: CGFloat = (R * 0.2126729) + (G * 0.7151522) + (B * 0.0721750)
        let z: CGFloat = (R * 0.0193339) + (G * 0.1191920) + (B * 0.9503041)
        return XYZColor(x: x, y: y, z: z, alpha: alpha)
    }

    public func toLAB() -> LABColor {
        toXYZ().toLAB()
    }

    public func toLCH() -> LCHColor {
        toXYZ().toLCH()
    }

    public func color() -> AgnosticColor {
        AgnosticColor(red: r, green: g, blue: b, alpha: alpha)
    }

    public func lerp(_ other: RGBColor, t: CGFloat) -> RGBColor {
        RGBColor(
            r: r + (other.r - r) * t,
            g: g + (other.g - g) * t,
            b: b + (other.b - b) * t,
            alpha: alpha + (other.alpha - alpha) * t
        )
    }
}
