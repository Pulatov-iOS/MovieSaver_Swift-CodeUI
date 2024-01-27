
import UIKit

final class Coordinator {
    
    let rootNavigationController: UINavigationController
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    func start() {
        showMovieListScreen()
    }
    
    private func showMovieListScreen() {
        let view = MovieListView()
        let presenter = DefaultMovieListPresenter(view: view)
        view.presenter = presenter
        rootNavigationController.pushViewController(view, animated: true)
    }
    
    private func showAddMovieScreen() {
        
    }
}
