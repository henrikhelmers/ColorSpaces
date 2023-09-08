import Foundation

public struct LCHColor {
    public let l: CGFloat     // 0..100
    public let c: CGFloat     // 0..128
    public let h: CGFloat     // 0..360
    public let alpha: CGFloat // 0..1

    public init (l: CGFloat, c: CGFloat, h: CGFloat, alpha: CGFloat) {
        self.l = l
        self.c = c
        self.h = h
        self.alpha = alpha
    }

    public func toLAB() -> LABColor {
        let RAD_TO_DEG = 180 / CGFloat.pi
        let rad = h / RAD_TO_DEG
        let a = cos(rad) * c
        let b = sin(rad) * c
        return LABColor(l: l, a: a, b: b, alpha: alpha)
    }

    public func toXYZ() -> XYZColor {
        toLAB().toXYZ()
    }

    public func toRGB() -> RGBColor {
        toXYZ().toRGB()
    }

    public func lerp(_ other: LCHColor, t: CGFloat) -> LCHColor {
        let angle: CGFloat = (((((other.h - h).truncatingRemainder(dividingBy: 360)) + 540).truncatingRemainder(dividingBy: 360)) - 180) * t
        return LCHColor(
            l: l + (other.l - l) * t,
            c: c + (other.c - c) * t,
            h: (h + angle + 360).truncatingRemainder(dividingBy: 360),
            alpha: alpha + (other.alpha - alpha) * t
        )
    }
}
