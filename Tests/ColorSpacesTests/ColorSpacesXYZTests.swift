import XCTest
@testable import ColorSpaces

class ColorSpacesXYZTests: XCTestCase {
    func testXYZToRGBX() {
        let xyz = XYZColor(x: 1, y: 0, z: 0, alpha: 1)
        let rgb = xyz.toRGB()
        XCTAssertEqual(rgb.r,  1.6668880, accuracy: 1e-6)
        XCTAssertEqual(rgb.g, -0.9863667, accuracy: 1e-6)
        XCTAssertEqual(rgb.b,  0.2615979, accuracy: 1e-6)
        XCTAssertEqual(rgb.alpha, 1, accuracy: 1e-6)
    }

    func testXYZToRGBY() {
        let xyz = XYZColor(x: 0, y: 1, z: 0, alpha: 1)
        let rgb = xyz.toRGB()
        XCTAssertEqual(rgb.r, -1.2069714, accuracy: 1e-6)
        XCTAssertEqual(rgb.g,  1.3161990, accuracy: 1e-6)
        XCTAssertEqual(rgb.b, -0.4890281, accuracy: 1e-6)
        XCTAssertEqual(rgb.alpha, 1, accuracy: 1e-6)
    }

    func testXYZToRGBZ() {
        let xyz = XYZColor(x: 0, y: 0, z: 1, alpha: 1)
        let rgb = xyz.toRGB()
        XCTAssertEqual(rgb.r, -0.7343888, accuracy: 1e-6)
        XCTAssertEqual(rgb.g,  0.2253387, accuracy: 1e-6)
        XCTAssertEqual(rgb.b,  1.0247476, accuracy: 1e-6)
        XCTAssertEqual(rgb.alpha, 1, accuracy: 1e-6)
    }

    func testXYZToRGBAndBack() {
        let a = XYZColor(x: 0.123, y: 0.456, z: 0.789, alpha: 0.3)
        let b = a.toRGB().toXYZ()
        XCTAssertEqual(a.x, b.x, accuracy: 1e-6)
        XCTAssertEqual(a.y, b.y, accuracy: 1e-6)
        XCTAssertEqual(a.z, b.z, accuracy: 1e-6)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-6)
    }

    func testXYZToLABX() {
        let xyz = XYZColor(x: 1, y: 0, z: 0, alpha: 1)
        let lab = xyz.toLAB()
        XCTAssertEqual(lab.l, 0, accuracy: 1e-5)
        XCTAssertEqual(lab.a, 439.5730164, accuracy: 1e-4)
        XCTAssertEqual(lab.b, 0, accuracy: 1e-5)
        XCTAssertEqual(lab.alpha, 1, accuracy: 1e-6)
    }

    func testXYZToLABY() {
        let xyz = XYZColor(x: 0, y: 1, z: 0, alpha: 1)
        let lab = xyz.toLAB()
        XCTAssertEqual(lab.l, 100, accuracy: 1e-5)
        XCTAssertEqual(lab.a, -431.0344827, accuracy: 1e-4)
        XCTAssertEqual(lab.b, 172.4137931, accuracy: 1e-5)
        XCTAssertEqual(lab.alpha, 1, accuracy: 1e-5)
        XCTAssertEqual(lab.alpha, 1)
    }

    func testXYZToLABZ() {
        let xyz = XYZColor(x: 0, y: 0, z: 1, alpha: 1)
        let lab = xyz.toLAB()
        XCTAssertEqual(lab.l, 0, accuracy: 1e-5)
        XCTAssertEqual(lab.a, 0, accuracy: 1e-5)
        XCTAssertEqual(lab.b, -166.8199296, accuracy: 1e-5)
        XCTAssertEqual(lab.alpha, 1, accuracy: 1e-6)
    }

    func testXYZToLABAndBack() {
        let a = XYZColor(x: 0.123, y: 0.456, z: 0.789, alpha: 0.3)
        let b = a.toLAB().toXYZ()
        XCTAssertEqual(a.x, b.x, accuracy: 1e-6)
        XCTAssertEqual(a.y, b.y, accuracy: 1e-6)
        XCTAssertEqual(a.z, b.z, accuracy: 1e-6)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-6)
    }

    func testXYZToLCH() {
        let original = XYZColor(x: 0.123, y: 0.456, z: 0.789, alpha: 0.3)
        let manual = original.toLAB().toLCH()
        let direct = original.toLCH()
        XCTAssertEqual(manual.l, direct.l, accuracy: 1e-6)
        XCTAssertEqual(manual.c, direct.c, accuracy: 1e-6)
        XCTAssertEqual(manual.h, direct.h, accuracy: 1e-6)
        XCTAssertEqual(manual.alpha, direct.alpha, accuracy: 1e-6)
    }

    func testXYZLerp() {
        let a = XYZColor(x: 0, y: 1, z: 2, alpha: 0.1)
        let b = XYZColor(x: 7, y: 8, z: 9, alpha: 0.9)
        let half = a.lerp(b, t: 0.5)
        let quarter = a.lerp(b, t: 0.25)

        XCTAssertEqual(half.x, 3.5, accuracy: 1e-8)
        XCTAssertEqual(half.y, 4.5, accuracy: 1e-8)
        XCTAssertEqual(half.z, 5.5, accuracy: 1e-8)
        XCTAssertEqual(half.alpha, 0.5, accuracy: 1e-8)

        XCTAssertEqual(quarter.x, 1.75, accuracy: 1e-8)
        XCTAssertEqual(quarter.y, 2.75, accuracy: 1e-8)
        XCTAssertEqual(quarter.z, 3.75, accuracy: 1e-8)
        XCTAssertEqual(quarter.alpha, 0.3, accuracy: 1e-8)
    }
}
