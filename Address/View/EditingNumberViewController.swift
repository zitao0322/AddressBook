import UIKit
import ReactiveCocoa
import ReactiveSwift

public class EditingNumberViewController: UIViewController {
    public var viewModel: EditingNumberViewModelType!

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    public class func instantiate() -> EditingNumberViewController {
        return UIStoryboard.init(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "EditingNumberViewController")
            as! EditingNumberViewController
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.title
        
        numberTextField.text = viewModel.number.value

        confirmButton.reactive.pressed = CocoaAction(viewModel.confirm)
        
        viewModel.bind(number: numberTextField.reactive.continuousTextValues)
    }
}
