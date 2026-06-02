// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import MCP

/// Compatibility extension. The offical MCP library added support for Metadata that we'd already added on a custom branch.
/// Rather then refactor everything to work with the MCP library which could change we add this layer to convert between, our representation and the mcp library representation
/// When things become more stable this can be removed
public extension Tool {
    
    var meta: ToolMeta? {
        get {
            guard let data = try? JSONEncoder().encode(self._meta) else {
                return nil
            }
            guard let helperVersion = try? JSONDecoder().decode(ToolMeta.self, from: data) else {
                return nil
            }
            return helperVersion
        }
        set {
            self._meta = newValue?.mcpSdkFormat
        }
    }
    
    /// Metadata that provide additional data about the tool, maps to the MCP Apps protocol
    public struct ToolMeta: Hashable, Codable, Equatable, Sendable {
        public var ui: UI?
        
        public struct UI: Hashable, Codable, Equatable, Sendable {
            public var resourceUri: String
            public var permissions: Permissions?
            public var csp: String?
            
            public struct Permissions: Hashable, Codable, Equatable, Sendable {
                var microphone: Bool?
                var camera: Bool?
                
                public init(microphone: Bool? = nil, camera: Bool? = nil) {
                    self.microphone = microphone
                    self.camera = camera
                }
                
                public init(from decoder: any Decoder) throws {
                    let container: KeyedDecodingContainer<Tool.ToolMeta.UI.Permissions.CodingKeys> = try decoder.container(keyedBy: Tool.ToolMeta.UI.Permissions.CodingKeys.self)
                    self.microphone = try container.decodeIfPresent(Bool.self, forKey: Tool.ToolMeta.UI.Permissions.CodingKeys.microphone)
                    self.camera = try container.decodeIfPresent(Bool.self, forKey: Tool.ToolMeta.UI.Permissions.CodingKeys.camera)
                }
                
                public enum CodingKeys: CodingKey {
                    case microphone
                    case camera
                }
                
                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.container(keyedBy: Tool.ToolMeta.UI.Permissions.CodingKeys.self)
                    try container.encodeIfPresent(self.microphone, forKey: Tool.ToolMeta.UI.Permissions.CodingKeys.microphone)
                    try container.encodeIfPresent(self.camera, forKey: Tool.ToolMeta.UI.Permissions.CodingKeys.camera)
                }
            }
            
            public init(resourceUri: String, permissions: Permissions? = nil, csp: String? = nil) {
                self.resourceUri = resourceUri
                self.permissions = permissions
                self.csp = csp
            }
            
            public enum CodingKeys: CodingKey {
                case resourceUri
                case permissions
                case csp
            }
            
            public init(from decoder: any Decoder) throws {
                let container: KeyedDecodingContainer<Tool.ToolMeta.UI.CodingKeys> = try decoder.container(keyedBy: Tool.ToolMeta.UI.CodingKeys.self)
                self.resourceUri = try container.decode(String.self, forKey: Tool.ToolMeta.UI.CodingKeys.resourceUri)
                self.permissions = try container.decodeIfPresent(Tool.ToolMeta.UI.Permissions.self, forKey: Tool.ToolMeta.UI.CodingKeys.permissions)
                self.csp = try container.decodeIfPresent(String.self, forKey: Tool.ToolMeta.UI.CodingKeys.csp)
            }
            
            public func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: Tool.ToolMeta.UI.CodingKeys.self)
                try container.encode(self.resourceUri, forKey: Tool.ToolMeta.UI.CodingKeys.resourceUri)
                try container.encodeIfPresent(self.permissions, forKey: Tool.ToolMeta.UI.CodingKeys.permissions)
                try container.encodeIfPresent(self.csp, forKey: Tool.ToolMeta.UI.CodingKeys.csp)
            }
        }
        
        public init(ui: UI? = nil) {
            self.ui = ui
        }
        
        enum CodingKeys: CodingKey {
            case ui
        }
        
        public init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<Tool.ToolMeta.CodingKeys> = try decoder.container(keyedBy: Tool.ToolMeta.CodingKeys.self)
            self.ui = try container.decodeIfPresent(Tool.ToolMeta.UI.self, forKey: Tool.ToolMeta.CodingKeys.ui)
        }
        
        public func encode(to encoder: any Encoder) throws {
            var container: KeyedEncodingContainer<Tool.ToolMeta.CodingKeys> = encoder.container(keyedBy: Tool.ToolMeta.CodingKeys.self)
            try container.encodeIfPresent(self.ui, forKey: Tool.ToolMeta.CodingKeys.ui)
        }
        
        var mcpSdkFormat: MCP.Metadata? {
            
            guard let data = try? JSONEncoder().encode(self) else {
                return nil
            }
            
            guard let mcpVersion = try? JSONDecoder().decode(Metadata.self, from: data) else {
                return nil
            }
            
            return mcpVersion
        }
    }
}


