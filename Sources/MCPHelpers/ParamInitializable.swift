//
//  ParamInitializable.swift
//  MCPHelpers
//
//  Created by Peter Liddle on 6/12/25.
//

import Foundation
import MCP

private struct TopLevelParamObject<T>: Decodable where T: Codable {
    var name: String
    var arguments: T
}

public protocol ParamInitializable: Codable {
    static var encoder: JSONEncoder { get }
    static var decoder: JSONDecoder { get }
}

public extension ParamInitializable {
    
    static var encoder: JSONEncoder {
        return JSONEncoder()
    }
    
    static var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    public init(with params: CallTool.Parameters) throws {
        
        // Not the neatest way to do it but params adheres to codable so turn to json then read back with decoder
        let encParams = try Self.encoder.encode(params)
        let object = try Self.decoder.decode(TopLevelParamObject<Self>.self, from: encParams)
        self = object.arguments
    }
}
