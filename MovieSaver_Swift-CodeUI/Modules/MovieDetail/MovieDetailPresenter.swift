import Dispatch

protocol MovieDetailPresenter: AnyObject {
    func setInformation(movie: Movie)
}

final class DefaultMovieDetailPresenter {
    
    // MARK: - Public properties
    unowned let view: MovieDetailView

    init(view: MovieDetailView) {
        self.view = view
    }
}

// MARK: - MovieDetailPresenter
extension DefaultMovieDetailPresenter: MovieDetailPresenter {
    
    func setInformation(movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.updateMovieView(movie: movie)
        }
    }
}
