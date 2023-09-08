//
//  ColorSpacesLABTests.swift
//  ColorSpaces
//
//  Created by Tim Wood on 10/5/15.
//  Copyright © 2015 Tim Wood. All rights reserved.
//

import XCTest
@testable import ColorSpaces

class ColorSpacesLABTests: XCTestCase {
    func testLABToXYZL() {
        let lab = LABColor(l: 1, a: 0, b: 0, alpha: 1)
        let xyz = lab.toXYZ()
        XCTAssertEqual(xyz.x, 0.0010522, accuracy: 1e-6)
        XCTAssertEqual(xyz.y, 0.0011070, accuracy: 1e-6)
        XCTAssertEqual(xyz.z, 0.0012053, accuracy: 1e-6)
        XCTAssertEqual(xyz.alpha, 1, accuracy: 1e-6)
    }
    
    func testLABToXYZA() {
        let lab = LABColor(l: 0, a: 1, b: 0, alpha: 1)
        let xyz = lab.toXYZ()
        XCTAssertEqual(xyz.x, 0.0002441, accuracy: 1e-6)
        XCTAssertEqual(xyz.y, 0, accuracy: 1e-6)
        XCTAssertEqual(xyz.z, 0, accuracy: 1e-6)
        XCTAssertEqual(xyz.alpha, 1, accuracy: 1e-6)
    }
    
    func testLABToXYZB() {
        let lab = LABColor(l: 0, a: 0, b: 1, alpha: 1)
        let xyz = lab.toXYZ()
        XCTAssertEqual(xyz.x, 0, accuracy: 1e-6)
        XCTAssertEqual(xyz.y, 0, accuracy: 1e-6)
        XCTAssertEqual(xyz.z, -0.0006991, accuracy: 1e-6)
        XCTAssertEqual(xyz.alpha, 1, accuracy: 1e-6)
    }
    
    func testLABToXYZAndBack() {
        let a = LABColor(l: 12, a: 34, b: 56, alpha: 0.3)
        let b = a.toXYZ().toLAB()
        XCTAssertEqual(a.l, b.l, accuracy: 1e-4)
        XCTAssertEqual(a.a, b.a, accuracy: 1e-4)
        XCTAssertEqual(a.b, b.b, accuracy: 1e-4)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-6)
    }
    
    func testLABToLCHL() {
        let lab = LABColor(l: 1, a: 2, b: 3, alpha: 1)
        let lch = lab.toLCH()
        XCTAssertEqual(lch.l, 1, accuracy: 1e-6)
        XCTAssertEqual(lch.c, 3.6055512, accuracy: 1e-6)
        XCTAssertEqual(lch.h, 56.3099324, accuracy: 1e-6)
        XCTAssertEqual(lch.alpha, 1, accuracy: 1e-6)
    }
    
    func testLABToLCHA() {
        let lab = LABColor(l: 3, a: -2, b: -1, alpha: 1)
        let lch = lab.toLCH()
        XCTAssertEqual(lch.l, 3, accuracy: 1e-6)
        XCTAssertEqual(lch.c, 2.23606797, accuracy: 1e-6)
        XCTAssertEqual(lch.h, 206.56505117, accuracy: 1e-6)
        XCTAssertEqual(lch.alpha, 1, accuracy: 1e-6)
    }
    
    func testLABToLCHAndBack() {
        let a = LABColor(l: 12, a: 34, b: 56, alpha: 0.3)
        let b = a.toLCH().toLAB()
        XCTAssertEqual(a.l, b.l, accuracy: 1e-6)
        XCTAssertEqual(a.a, b.a, accuracy: 1e-6)
        XCTAssertEqual(a.b, b.b, accuracy: 1e-6)
        XCTAssertEqual(a.alpha, b.alpha, accuracy: 1e-6)
    }
    
    func testLABToRGB() {
        let original = LABColor(l: 12, a: 34, b: 56, alpha: 0.3)
        let manual = original.toXYZ().toRGB()
        let direct = original.toRGB()
        XCTAssertEqual(manual.r, direct.r, accuracy: 1e-6)
        XCTAssertEqual(manual.g, direct.g, accuracy: 1e-6)
        XCTAssertEqual(manual.b, direct.b, accuracy: 1e-6)
        XCTAssertEqual(manual.alpha, direct.alpha, accuracy: 1e-6)
    }
    
    func testLABLerp() {
        let a = LABColor(l: 10, a: -120, b: -40, alpha: 0.1)
        let b = LABColor(l: 90, a: 20, b: 90, alpha: 0.4)
        let half = a.lerp(b, t: 0.5)
        let quarter = a.lerp(b, t: 0.25)
        
        XCTAssertEqual(half.l, 50, accuracy: 1e-8)
        XCTAssertEqual(half.a, -50, accuracy: 1e-8)
        XCTAssertEqual(half.b, 25, accuracy: 1e-8)
        XCTAssertEqual(half.alpha, 0.25, accuracy: 1e-8)
        
        XCTAssertEqual(quarter.l, 30, accuracy: 1e-8)
        XCTAssertEqual(quarter.a, -85, accuracy: 1e-8)
        XCTAssertEqual(quarter.b, -7.5, accuracy: 1e-8)
        XCTAssertEqual(quarter.alpha, 0.175, accuracy: 1e-8)
    }
}
