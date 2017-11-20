//
//  MintedTokenTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 20/11/2560 BE.
//  Copyright © 2560 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class MintedTokenTests: XCTestCase {

    func testEquatable() {
        let mintedToken1 = MintedToken(id: "OMG:123", symbol: "", name: "", subUnitToUnit: 1)
        let mintedToken2 = MintedToken(id: "OMG:123", symbol: "", name: "", subUnitToUnit: 1)
        let mintedToken3 = MintedToken(id: "BTC:123", symbol: "", name: "", subUnitToUnit: 1)
        XCTAssertEqual(mintedToken1, mintedToken2)
        XCTAssertNotEqual(mintedToken1, mintedToken3)
    }

    func testHashable() {
        let mintedToken1 = MintedToken(id: "OMG:123", symbol: "", name: "", subUnitToUnit: 1)
        let mintedToken2 = MintedToken(id: "OMG:123", symbol: "", name: "", subUnitToUnit: 1)
        let set: Set<MintedToken> = [mintedToken1, mintedToken2]
        XCTAssertEqual(mintedToken1.hashValue, "OMG:123".hashValue)
        XCTAssertEqual(set.count, 1)
    }

}
