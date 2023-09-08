import XCTest
@testable import ColorSpaces

class ColorSpacesLCHTests: XCTestCase {
    func testLCHToLAB1() {
        let lch = LCHColor(l: 1, c: 2, h: 345, alpha: 1)
        let lab = lch.toLAB()
        XCTAssertEqual(lab.l, 1, accuracy: 1e-6)
        XCTAssertEqual(lab.a, 1.93185165, accuracy: 1e-6)
        XCTAssertEqual(lab.b, -0.51763809, accuracy: 1e-6)
        XCTAssertEqual(lch.alpha, 1, accuracy: 1e-6)
    }

    func testLCHToLAB2() {
        let lch = LCHColor(l: 100, c: 234, h: 56, alpha: 1)
        let lab = lch.toLAB()
        XCTAssertEqual(lab.l, 100, accuracy: 1e-6)
        XCTAssertEqual(lab.a, 130.85113941, accuracy: 1e-6)
        XCTAssertEqual(lab.b, 193.99479197, accuracy: 1e-6)
        XCTAssertEqual(lch.alpha, 1, accuracy: 1e-6)
    }

    func testLCHToLABAndBack() {
        let a = LCHColor(l: 12, c: 34, h: 56, alpha: 0.3)
        let b = a.toLAB().toLCH()
        XCTAssertEqual(a.l, b.l, accuracy: 1e-6)
        XCTAssertEqual(a.c, b.c, accuracy: 1e-6)
        XCTAssertEqual(a.h, b.h, accuracy: 1e-6)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-6)
    }

    func testLCHToXYZ() {
        let original = LCHColor(l: 12, c: 34, h: 56, alpha: 0.3)
        let manual = original.toLAB().toXYZ()
        let direct = original.toXYZ()
        XCTAssertEqual(manual.x, direct.x, accuracy: 1e-6)
        XCTAssertEqual(manual.y, direct.y, accuracy: 1e-6)
        XCTAssertEqual(manual.z, direct.z, accuracy: 1e-6)
        XCTAssertEqual(manual.alpha, direct.alpha, accuracy: 1e-6)
    }

    func testLCHToRGB() {
        let original = LCHColor(l: 12, c: 34, h: 56, alpha: 0.3)
        let manual = original.toLAB().toXYZ().toRGB()
        let direct = original.toRGB()
        XCTAssertEqual(manual.r, direct.r, accuracy: 1e-6)
        XCTAssertEqual(manual.g, direct.g, accuracy: 1e-6)
        XCTAssertEqual(manual.b, direct.b, accuracy: 1e-6)
        XCTAssertEqual(manual.alpha, direct.alpha, accuracy: 1e-6)
    }

    func testLCHLerp() {
        let a = LCHColor(l: 10, c: 70, h: 40, alpha: 0.8)
        let b = LCHColor(l: 90, c: 20, h: 90, alpha: 0.1)
        let half = a.lerp(b, t: 0.5)
        let quarter = a.lerp(b, t: 0.25)

        XCTAssertEqual(half.l, 50, accuracy: 1e-8)
        XCTAssertEqual(half.c, 45, accuracy: 1e-8)
        XCTAssertEqual(half.h, 65, accuracy: 1e-8)
        XCTAssertEqual(half.alpha, 0.45, accuracy: 1e-8)

        XCTAssertEqual(quarter.l, 30, accuracy: 1e-8)
        XCTAssertEqual(quarter.c, 57.5, accuracy: 1e-8)
        XCTAssertEqual(quarter.h, 52.5, accuracy: 1e-8)
        XCTAssertEqual(quarter.alpha, 0.625, accuracy: 1e-8)
    }

    func testLCHLerpWithinHueBoundary() {
        let a = LCHColor(l: 10, c: 70, h: 40, alpha: 0.8)
        let b = LCHColor(l: 90, c: 20, h: 90, alpha: 0.1)
        let a2b = a.lerp(b, t: 0.5)
        let b2a = b.lerp(a, t: 0.5)

        XCTAssertEqual(a2b.h, b2a.h, accuracy: 1e-8)
    }

    func testLCHLerpAcrossHueBoundary() {
        let a = LCHColor(l: 0, c: 0, h: 271, alpha: 1)
        let b = LCHColor(l: 0, c: 0, h: 89, alpha: 1)
        let a2b = a.lerp(b, t: 0.5)
        let b2a = b.lerp(a, t: 0.5)

        XCTAssertEqual(a2b.h, 0, accuracy: 1e-8)
        XCTAssertEqual(b2a.h, 0, accuracy: 1e-8)
    }

    func testLCHLerpAcrossHueBoundary2() {
        let a = LCHColor(l: 0, c: 0, h: 350, alpha: 1)
        let b = LCHColor(l: 0, c: 0, h: 70, alpha: 1)
        let a2b = a.lerp(b, t: 0.5)
        let b2a = b.lerp(a, t: 0.5)

        XCTAssertEqual(a2b.h, 30, accuracy: 1e-8)
        XCTAssertEqual(b2a.h, 30, accuracy: 1e-8)
    }

    func testLCHLerpAcrossHueBoundaryNonLooping() {
        let a = LCHColor(l: 0, c: 0, h: 350, alpha: 1)
        let b = LCHColor(l: 0, c: 0, h: 10, alpha: 1)
        let a2b25 = a.lerp(b, t: 0.25)
        let a2b50 = a.lerp(b, t: 0.5)
        let a2b75 = a.lerp(b, t: 0.75)
        let b2a25 = b.lerp(a, t: 0.25)
        let b2a50 = b.lerp(a, t: 0.5)
        let b2a75 = b.lerp(a, t: 0.75)

        XCTAssertEqual(a2b25.h, 355, accuracy: 1e-8)
        XCTAssertEqual(a2b50.h, 0, accuracy: 1e-8)
        XCTAssertEqual(a2b75.h, 5, accuracy: 1e-8)
        XCTAssertEqual(b2a25.h, 5, accuracy: 1e-8)
        XCTAssertEqual(b2a50.h, 0, accuracy: 1e-8)
        XCTAssertEqual(b2a75.h, 355, accuracy: 1e-8)
    }
}
