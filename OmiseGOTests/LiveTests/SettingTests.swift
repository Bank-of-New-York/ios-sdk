//
//  SettingTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 10/11/2560 BE.
//  Copyright © 2560 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class SettingTests: LiveTestCase {

    func testGetSettings() {
        let expectation = self.expectation(description: "Setting result")
        let request = Setting.get(using: self.testClient) { (result) in
            defer { expectation.fulfill() }
            switch result {
            case .success(let setting):
                XCTAssert(!setting.mintedTokens.isEmpty)
            case .fail(let error):
                XCTFail("\(error)")
            }
        }
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 15.0, handler: nil)
    }

}
