import Foundation
import ReactiveSwift
import Result

private let dataSource: [Address] = [
    Address(name: "第一名", number: "123456789"),
    Address(name: "第二名", number: "123456789"),
    Address(name: "第三名", number: "123456789"),
    Address(name: "第四名", number: "123456789"),
    Address(name: "第五名", number: "123456789"),
    Address(name: "第六名", number: "123456789")
]

public protocol AddressViewModelType {
    typealias Item = AddressItemViewModelType
    typealias Detail = Item.Detail

    var items: Property<[Item]> { get }
    var refresh: Action<(), [Address], NoError> { get }
    var showDetail: Signal<Detail, NoError> { get }
}

public struct AddressViewModel: AddressViewModelType {
    public let items: Property<[Item]>
    public let refresh: Action<(), [Address], NoError>
    public let showDetail: Signal<Detail, NoError>
    
    public init() {
        let _items = MutableProperty<[Item]>([])
        self.items = Property(capturing: _items)
        
        func transfromToShowDetail(list: [Item]) -> Signal<Detail, NoError> {
            let signals = list.map { $0.showDetail.values }
            return Signal.merge(signals)
        }
        self.showDetail = items.signal.map(transfromToShowDetail).flatten(.latest)
        
        self.refresh = Action { .init(value: dataSource) }
        
        _items <~ refresh.values.map { $0.map(AddressItemViewModel.init(model: )) }
    }
}
