
protocol MovieListPresenter: AnyObject {
    func addMovieButtonTapped()
}

final class DefaultMovieListPresenter {
    
    unowned let view: MovieListView
    var showAddMoviePage: (() -> Void)?
    
    // MARK: - Private properties
//    private let movies: Movie
    
    init(view: MovieListView) {
        self.view = view
    }
    
}

// MARK: - MovieListPresenter
extension DefaultMovieListPresenter: MovieListPresenter {
    
    func addMovieButtonTapped() {
        showAddMoviePage?()
    }
}
