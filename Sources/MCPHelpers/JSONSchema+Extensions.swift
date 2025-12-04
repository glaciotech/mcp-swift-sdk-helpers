//
//  JSONSchema+Extensions.swift
//  MCPHelpers
//
//  Created by Peter Liddle on 6/22/25.
//

import Foundation
import SwiftyJsonSchema
import MCP

public extension JSONSchema {
    
    static var encoder: JSONEncoder {
        return JSONEncoder()
    }
    
    static var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    public init(fromValue value: SwiftyJsonSchema.Value) throws {
        let encodedJSON = try Self.encoder.encode(value)
        self = try Self.decoder.decode(JSONSchema.self, from: encodedJSON)
    }
    
    public init(fromMCPValue mcpValue: MCP.Value) throws {
        let encodedJSON = try Self.encoder.encode(mcpValue)
        self = try Self.decoder.decode(JSONSchema.self, from: encodedJSON)
    }
}
