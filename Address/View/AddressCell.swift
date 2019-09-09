import UIKit

public class AddressCell: UITableViewCell {
    public var viewModel: AddressItemViewModelType? {
        didSet {
            viewModel.map { configSubViews(viewModel: $0) }
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    private func configSubViews(viewModel: AddressItemViewModelType) {
        nameLabel.text = viewModel.name
        numberLabel.text = viewModel.number
    }
}
