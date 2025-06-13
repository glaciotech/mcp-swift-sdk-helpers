//
//  Value+SwiftyJsonSchema.swift
//  mcp-swift-sdk
//
//  Created by Peter Liddle on 6/11/25.
//

import Foundation
import SwiftyJsonSchema
import MCP

public extension Value {
    public static func produced<T>(from schemaType: T.Type) throws -> Value where T: ProducesJSONSchema {
        return try Value.init(JsonSchemaCreator.createJSONSchema(for: T.exampleValue))
    }
}
