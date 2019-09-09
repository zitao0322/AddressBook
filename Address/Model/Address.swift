import Foundation

public struct Address {
    public let name: String
    public let number: String
}

extension Address: Encodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case number
    }
    
    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        
        try c.encode(name, forKey: .name)
        try c.encode(number, forKey: .number)
    }
}
