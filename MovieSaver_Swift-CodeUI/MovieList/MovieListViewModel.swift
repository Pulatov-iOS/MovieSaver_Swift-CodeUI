
protocol MovieListViewModel: AnyObject {
    
}

final class DefaultMovieListViewModel: MovieListViewModel {
    
    // MARK: - Private properties
    private let movies: Movie
}
