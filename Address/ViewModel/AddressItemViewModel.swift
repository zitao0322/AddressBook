import Foundation
import ReactiveSwift
import Result

public protocol AddressItemViewModelType {
    typealias Detail = EditingNumberViewModelType
    
    var name: String { get }
    var number: Property<String> { get }
    var showDetail: Action<(), Detail, NoError> { get }
}

public struct AddressItemViewModel: AddressItemViewModelType {
    public let name: String
    public let number: Property<String>
    public let showDetail: Action<(), Detail, NoError>
    
    public init(model: Address) {
        self.name = model.name
        
        let _number = MutableProperty<String>(model.number)
        self.number = Property<String>(capturing: _number)

        self.showDetail = Action(state: _number) {
            let address = Address(name: model.name, number: $0)
            return .init(value: EditingNumberViewModel(model: address))
        }
        
        _number <~ showDetail.values.map { $0.confirm.values }.flatten(.latest)
    }
}
