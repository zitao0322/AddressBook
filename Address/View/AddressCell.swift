import UIKit
import ReactiveCocoa
import ReactiveSwift

public class AddressCell: UITableViewCell {
    public var viewModel: AddressItemViewModelType? {
        didSet {
            disposable = viewModel.map { configSubViews(viewModel: $0) } ?? nil
        }
    }
    
    private var disposable: Disposable? {
        didSet {
            oldValue?.dispose()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    private func configSubViews(viewModel: AddressItemViewModelType) -> Disposable? {
        let disposable = CompositeDisposable()
        
        nameLabel.text = viewModel.name
        
        disposable += numberLabel.reactive.text <~ viewModel.number
        
        return disposable
    }
}
