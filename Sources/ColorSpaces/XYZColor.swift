import Foundation

public struct XYZColor {
    /// 0..0.95047
    public let x: CGFloat
    /// 0..1
    public let y: CGFloat
    /// 0..1.08883
    public let z: CGFloat
    /// 0..1
    public let alpha: CGFloat

    public init (x: CGFloat, y: CGFloat, z: CGFloat, alpha: CGFloat) {
        self.x = x
        self.y = y
        self.z = z
        self.alpha = alpha
    }

    fileprivate func sRGBCompand(_ v: CGFloat) -> CGFloat {
        let absV = abs(v)
        let out = absV > 0.0031308 ? 1.055 * pow(absV, 1 / 2.4) - 0.055 : absV * 12.92
        return v > 0 ? out : -out
    }

    public func toRGB() -> RGBColor {
        let r = (x *  3.2404542) + (y * -1.5371385) + (z * -0.4985314)
        let g = (x * -0.9692660) + (y *  1.8760108) + (z *  0.0415560)
        let b = (x *  0.0556434) + (y * -0.2040259) + (z *  1.0572252)
        let R = sRGBCompand(r)
        let G = sRGBCompand(g)
        let B = sRGBCompand(b)
        return RGBColor(r: R, g: G, b: B, alpha: alpha)
    }

    fileprivate func labCompand(_ v: CGFloat) -> CGFloat {
        let LAB_16_116: CGFloat = 0.1379310
        let LAB_K_116: CGFloat = 7.787036
        let LAB_E: CGFloat = 0.008856
        return v > LAB_E ? pow(v, 1.0 / 3.0) : (LAB_K_116 * v) + LAB_16_116
    }

    public func toLAB() -> LABColor {
        let LAB_X: CGFloat = 0.95047
        let LAB_Y: CGFloat = 1
        let LAB_Z: CGFloat = 1.08883
        let fx = labCompand(x / LAB_X)
        let fy = labCompand(y / LAB_Y)
        let fz = labCompand(z / LAB_Z)
        return LABColor(
            l: 116 * fy - 16,
            a: 500 * (fx - fy),
            b: 200 * (fy - fz),
            alpha: alpha
        )
    }

    public func toLCH() -> LCHColor {
        toLAB().toLCH()
    }

    public func lerp(_ other: XYZColor, t: CGFloat) -> XYZColor {
        XYZColor(
            x: x + (other.x - x) * t,
            y: y + (other.y - y) * t,
            z: z + (other.z - z) * t,
            alpha: alpha + (other.alpha - alpha) * t
        )
    }
}
