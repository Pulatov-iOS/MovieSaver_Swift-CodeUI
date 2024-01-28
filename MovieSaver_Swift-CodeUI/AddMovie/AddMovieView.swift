
import UIKit

protocol AddMovieView: AnyObject {
    
}

final class DefaultAddMovieView: UIViewController {
    
    // MARK: - Public properties
    var presenter: AddMoviePresenter!
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
    
}

// MARK: - AddMovieView
extension DefaultAddMovieView: AddMovieView {
    
}
