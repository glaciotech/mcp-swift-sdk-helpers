//
//  MCPHelpers.swift
//  VentusNotesMCP
//
//  Created by Peter Liddle on 1/15/26.
//

import Foundation
import MCPHelpers
import MCP
import Logging
import SwiftyJsonSchema

public protocol ToolDefinitonProtocol {
    associatedtype Schema: ProducesJSONSchema
    
    static var resourceUri: String? { get }
    
    static var name: String { get }
    static var description: String { get }
    
    static func definition() throws -> Tool
}

public protocol ToolDefiniton: ToolDefinitonProtocol {
    func run(with params: CallTool.Parameters) throws -> CallTool.Result
}

public protocol AsyncToolDefiniton: ToolDefinitonProtocol {
    
    static var name: String { get }
    static var description: String { get }
    
    func run(with params: CallTool.Parameters) async throws -> CallTool.Result
}

extension ToolDefinitonProtocol {
    public static func definition() throws -> Tool {
        let schema = try MCP.Value.produced(from: Schema.self)
        
        let meta: Tool.ToolMeta? = {
            if let resourceUri = self.resourceUri {
                return .init(ui: .init(resourceUri: resourceUri))
            }
            else {
                return nil
            }
        }()
        
        return Tool(name: self.name, description: self.description, inputSchema: schema, meta: meta)
    }
}
