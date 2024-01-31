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
        
        presenter.showAddMovieNamePage = { [weak self] movieName in
            self?.showAddMovieNameScreen(movieName, completion: { savedMovieName in
                presenter.updateMovieName(movieName: savedMovieName)
            })
        }
        
        presenter.showAddMovieRatingPage = { [weak self] movieRating in
            self?.showAddMovieRatingScreen(movieRating, completion: { savedMovieRating in
                presenter.updateMovieRating(movieRating: savedMovieRating)
            })
        }
        
        presenter.showAddMovieReleaseDatePage = { [weak self] movieReleaseDate in
            self?.showAddMovieReleaseDateScreen(movieReleaseDate, completion: { savedMovieReleaseDate in
                presenter.updateMovieReleaseDate(movieReleaseDate: savedMovieReleaseDate)
            })
        }
        
        presenter.showAddMovieLinkPage = { [weak self] movieLink in
            self?.showAddMovieLinkScreen(movieLink, completion: { savedMovieLink in
                presenter.updateMovieLink(movieLink: savedMovieLink)
            })
        }
        
        presenter.closeAddMovieScreen = { [weak self] in
            self?.closeCurrentScreen()
        }
    }
    
    private func showMovieDetailScreen(movie: Movie) {
        let view = DefaultMovieDetailView()
        let presenter = DefaultMovieDetailPresenter(view: view)
        view.presenter = presenter
        presenter.setInformation(movie: movie)
        rootNavigationController.pushViewController(view, animated: true)
    }
    
    private func showAddMovieNameScreen(_ movieName: String, completion: @escaping (String) -> Void) {
        let view = DefaultAddMovieNameView()
        let presenter = DefaultAddMovieNamePresenter(view: view)
        view.presenter = presenter
        presenter.setMovieName(movieName)
        rootNavigationController.pushViewController(view, animated: true)
        
        presenter.savedMovieName = { savedMovieName in
            completion(savedMovieName)
        }
        
        presenter.closeAddMovieNameScreen = { [weak self] in
            self?.closeCurrentScreen()
        }
    }
    
    private func showAddMovieRatingScreen(_ movieRating: Double, completion: @escaping (Double) -> Void) {
        let view = DefaultAddMovieRatingView()
        let presenter = DefaultAddMovieRatingPresenter(view: view)
        view.presenter = presenter
        presenter.setMovieRating(movieRating)
        rootNavigationController.pushViewController(view, animated: true)
        
        presenter.savedMovieRating = { savedMovieRating in
            completion(savedMovieRating)
        }
        
        presenter.closeAddMovieRatingScreen = { [weak self] in
            self?.closeCurrentScreen()
        }
    }
    
    private func showAddMovieReleaseDateScreen(_ movieReleaseDate: Date, completion: @escaping (Date) -> Void) {
        let view = DefaultAddMovieReleaseDateView()
        let presenter = DefaultAddMovieReleaseDatePresenter(view: view)
        view.presenter = presenter
        presenter.setMovieReleaseDate(movieReleaseDate)
        rootNavigationController.pushViewController(view, animated: true)
        
        presenter.savedMovieReleaseDate = { savedMovieReleaseDate in
            completion(savedMovieReleaseDate)
        }
        
        presenter.closeAddMovieReleaseDateScreen = { [weak self] in
            self?.closeCurrentScreen()
        }
    }
    
    
    private func showAddMovieLinkScreen(_ movieLink: String, completion: @escaping (String) -> Void) {
        let view = DefaultAddMovieLinkView()
        let presenter = DefaultAddMovieLinkPresenter(view: view)
        view.presenter = presenter
        presenter.setMovieLink(movieLink)
        rootNavigationController.pushViewController(view, animated: true)
        
        presenter.savedMovieLink = { savedMovieLink in
            completion(savedMovieLink)
        }
        
        presenter.closeAddMovieLinkScreen = { [weak self] in
            self?.closeCurrentScreen()
        }
    }
    
    private func closeCurrentScreen() {
        rootNavigationController.popViewController(animated: true)
    }
}
