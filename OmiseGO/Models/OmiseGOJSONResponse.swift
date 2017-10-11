//
//  OmiseGOJSONResponse.swift
//  OmiseGO
//
//  Created by Mederic Petit on 10/10/2560 BE.
//  Copyright © 2560 OmiseGO. All rights reserved.
//

import UIKit

public struct OmiseGOJSONResponse<ObjectType: OmiseGOObject> {

    public let version: String
    public let success: Bool
    public let data: Failable<ObjectType, APIError>

}

extension OmiseGOJSONResponse: Codable {

    private enum CodingKeys: String, CodingKey {
        case version
        case success
        case data
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        version = try container.decode(String.self, forKey: .version)
        success = try container.decode(Bool.self, forKey: .success)
        if success {
            let result = try container.decode(ObjectType.self, forKey: .data)
            data = Failable.success(result)
        } else {
            let error = try container.decode(APIError.self, forKey: .data)
            data = Failable.fail(error)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(version, forKey: .version)
        try container.encode(success, forKey: .success)
        switch data {
        case .success(let result):
            try container.encode(result, forKey: .data)
        case .fail(let error):
            try container.encode(error, forKey: .data)
        }
    }

}
