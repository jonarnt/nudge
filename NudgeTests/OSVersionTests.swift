//
//  OSVersionTests.swift
//  NudgeTests
//
//  Created by Victor Vrantchan on 2/5/21.
//

import Foundation
import XCTest
@testable import Nudge

class OSVersionTest: XCTestCase {
    func testCompare() {
        let a = OSVersion(major: 11, minor: 2, patch: 0)
        let b = OSVersion(major: 11, minor: 2, patch: 0)
        let c = OSVersion(major: 11, minor: 3, patch: 0)
        let d = OSVersion(major: 10, minor: 15, patch: 9999)

        XCTAssertEqual(a,b)
        XCTAssertNotEqual(a,c)
        XCTAssertGreaterThan(c,b)
        XCTAssertGreaterThanOrEqual(c,d)
        XCTAssertFalse(a < d, "BigSur is newer than Catalina")
    }

    func testParse() {
        let expected = OSVersion(major: 11, minor: 5, patch: 0)
        guard let actual = try? OSVersion("11.5") else {
            XCTFail("expected OSVersion to not fail parsing '11.5'")
            return
        }

        XCTAssertEqual(expected, actual)
    }

    func testMacOS26TahoeVersionJump() {
        let sequoia = OSVersion(major: 15, minor: 5, patch: 0)
        let tahoe = OSVersion(major: 26, minor: 0, patch: 0)
        let tahoePatch = OSVersion(major: 26, minor: 3, patch: 0)

        XCTAssertGreaterThan(tahoe, sequoia, "Tahoe (26) should be greater than Sequoia (15)")
        XCTAssertGreaterThan(tahoePatch, tahoe, "Tahoe 26.3 should be greater than Tahoe 26.0")
        XCTAssertFalse(sequoia > tahoe, "Sequoia should not be greater than Tahoe")
    }

    func testParseMacOS26TahoeVersion() {
        guard let tahoe = try? OSVersion("26.0") else {
            XCTFail("expected OSVersion to not fail parsing '26.0'")
            return
        }
        XCTAssertEqual(tahoe.major, 26)
        XCTAssertEqual(tahoe.minor, 0)
        XCTAssertEqual(tahoe.patch, 0)

        guard let tahoePatch = try? OSVersion("26.3.1") else {
            XCTFail("expected OSVersion to not fail parsing '26.3.1'")
            return
        }
        XCTAssertEqual(tahoePatch.major, 26)
        XCTAssertEqual(tahoePatch.minor, 3)
        XCTAssertEqual(tahoePatch.patch, 1)
    }
}
