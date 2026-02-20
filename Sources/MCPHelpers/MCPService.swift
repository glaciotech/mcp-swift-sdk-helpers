//
//  MCPService.swift
//  VulcanMCP
//
//  Created by Peter Liddle on 5/27/25.
//
import MCP
import ServiceLifecycle
import Logging

public struct MCPService: Service {
    
    let server: Server
    let transport: Transport
    
    public init(server: Server, transport: Transport) {
        self.server = server
        self.transport = transport
    }
    
    public func run() async throws {
        // Start the server
        try await server.start(transport: transport)

        // Keep running until external cancellation
        try await Task.sleep(for: .seconds(10000)) 
    }

    public func shutdown() async throws {
        // Gracefully shutdown the server
        await server.stop()
    }
}
