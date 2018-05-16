//
//  RequestBuilderTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 16/5/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

import XCTest
@testable import OmiseGO

class RequestBuilderTest: XCTestCase {

    func testBuildRequest() {
        do {
            let validConfig: ClientConfiguration = ClientConfiguration(baseURL: "https://example.com",
                                                                       apiKey: "apikey",
                                                                       authenticationToken: "authenticationtoken")
            let urlRequest = try RequestBuilder(configuration: validConfig)
                .buildHTTPURLRequest(withEndpoint: .custom(path: "", task: .requestPlain))

            guard let httpHeaders = urlRequest.allHTTPHeaderFields else {
                XCTFail("Missing HTTP headers")
                return
            }

            XCTAssertEqual(httpHeaders["Authorization"], "OMGClient YXBpa2V5OmF1dGhlbnRpY2F0aW9udG9rZW4=")
            XCTAssertEqual(httpHeaders["Accept"],
                           "application/vnd.omisego.v\(validConfig.apiVersion)+json")
            XCTAssertEqual(httpHeaders["Content-Type"],
                           "application/vnd.omisego.v\(validConfig.apiVersion)+json; charset=utf-8")
            XCTAssertNil(urlRequest.httpBody)
            XCTAssertEqual(urlRequest.httpMethod, "POST")
            XCTAssertEqual(urlRequest.timeoutInterval, 6)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}
