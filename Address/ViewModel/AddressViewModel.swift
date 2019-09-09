import Foundation
import ReactiveSwift
import Result

public protocol AddressViewModelType {
    var name: String { get }
    var number: String { get }
    var showDetail: Action<(), String, NoError> { get }
}

public struct AddressViewModel: AddressViewModelType {
    public let name: String
    public let number: String
    public let showDetail: Action<(), String, NoError>
    
    public init(model: Address) {
        self.name = model.name
        self.number = model.number
        
        self.showDetail = Action { .init(value: model.name) }
    }
}
