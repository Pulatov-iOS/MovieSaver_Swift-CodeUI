
protocol MovieListPresenter: AnyObject {
    
}

final class DefaultMovieListPresenter: MovieListPresenter {
    
    unowned let view: MovieListView
    
    // MARK: - Private properties
//    private let movies: Movie
    
    init(view: MovieListView) {
        self.view = view
    }
}
