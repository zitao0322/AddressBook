import UIKit
import ReactiveCocoa
import ReactiveSwift

public class AddressViewController: UIViewController {
    
    // MARK: Public Properties
    
    public var viewModel: AddressViewModelType = AddressViewModel()
    
    // MARK: Private Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reactive.reloadData <~ viewModel.items.signal.map { _ in }
        
        viewModel.showDetail.observeValues { [unowned self] in
            self.showAddressDetail($0)
        }
        
        viewModel.refresh.apply().start()
    }
    
    private func showAddressDetail(_ viewModel: EditingNumberViewModelType) {
        let vc = EditingNumberViewController.instantiate()
        vc.viewModel = viewModel
        navigationController?.show(vc, sender: nil)
    }
}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        cell.viewModel = viewModel.items.value[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellModel = viewModel.items.value[indexPath.row]
        cellModel.showDetail.apply().start()
    }
}
