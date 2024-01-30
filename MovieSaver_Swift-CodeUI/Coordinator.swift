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
        let view = DefaultMovieListView()
        let presenter = DefaultMovieListPresenter(view: view)
        view.presenter = presenter
        rootNavigationController.pushViewController(view, animated: true)
        
        presenter.showAddMoviePage = { [weak self] in
            self?.showAddMovieScreen()
        }
        
        presenter.showMovieDetailPage = { [weak self] movie in
            self?.showMovieDetailScreen(movie: movie)
        }
    }
    
    private func showAddMovieScreen() {
        let view = DefaultAddMovieView()
        let presenter = DefaultAddMoviePresenter(view: view)
        view.presenter = presenter
        rootNavigationController.pushViewController(view, animated: true)
    }
    
    private func showMovieDetailScreen(movie: Movie) {
        let view = DefaultMovieDetailView()
        let presenter = DefaultMovieDetailPresenter(view: view)
        view.presenter = presenter
        presenter.setInformation(movie: movie)
        rootNavigationController.pushViewController(view, animated: true)
    }
}
