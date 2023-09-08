import Foundation

public struct LABColor {
    /// 0..100
    public let l: CGFloat
    /// -128..128
    public let a: CGFloat
    /// -128..128
    public let b: CGFloat
    /// 0..1
    public let alpha: CGFloat

    public init (l: CGFloat, a: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.l = l
        self.a = a
        self.b = b
        self.alpha = alpha
    }

    fileprivate func xyzCompand(_ v: CGFloat) -> CGFloat {
        let LAB_E: CGFloat = 0.008856
        let LAB_16_116: CGFloat = 0.1379310
        let LAB_K_116: CGFloat = 7.787036
        let v3 = v * v * v
        return v3 > LAB_E ? v3 : (v - LAB_16_116) / LAB_K_116
    }

    public func toXYZ() -> XYZColor {
        let LAB_X: CGFloat = 0.95047
        let LAB_Y: CGFloat = 1
        let LAB_Z: CGFloat = 1.08883
        let y = (l + 16) / 116
        let x = y + (a / 500)
        let z = y - (b / 200)
        return XYZColor(
            x: xyzCompand(x) * LAB_X,
            y: xyzCompand(y) * LAB_Y,
            z: xyzCompand(z) * LAB_Z,
            alpha: alpha
        )
    }

    public func toLCH() -> LCHColor {
        let RAD_TO_DEG = 180 / CGFloat.pi
        let c = sqrt(a * a + b * b)
        let angle = atan2(b, a) * RAD_TO_DEG
        let h = angle < 0 ? angle + 360 : angle
        return LCHColor(l: l, c: c, h: h, alpha: alpha)
    }

    public func toRGB() -> RGBColor {
        toXYZ().toRGB()
    }

    public func lerp(_ other: LABColor, t: CGFloat) -> LABColor {
        LABColor(
            l: l + (other.l - l) * t,
            a: a + (other.a - a) * t,
            b: b + (other.b - b) * t,
            alpha: alpha + (other.alpha - alpha) * t
        )
    }
}
