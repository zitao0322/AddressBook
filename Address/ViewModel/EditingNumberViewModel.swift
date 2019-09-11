import Foundation
import ReactiveSwift
import Result

public protocol EditingNumberViewModelType {
    var title: String { get }
    var number: Property<String> { get }
    var confirm: Action<(), String, NoError> { get }
    
    func bind(number: Signal<String, NoError>)
}

public struct EditingNumberViewModel: EditingNumberViewModelType {
    public let title: String
    public let number: Property<String>
    public let confirm: Action<(), String, NoError>
    
    private let _number: MutableProperty<String>
    
    public init(model: Address) {
        self.title = model.name
        
        self._number = MutableProperty<String>(model.number)
        self.number = Property(capturing: _number)
        
        self.confirm = Action(state: _number, execute: { .init(value: $0) })
    }
    
    public func bind(number: Signal<String, NoError>) {
        _number <~ number
    }
}
