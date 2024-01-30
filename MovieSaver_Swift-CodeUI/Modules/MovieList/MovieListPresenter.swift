import Dispatch

protocol MovieListPresenter: AnyObject {
    func getMovies()
    func addMovieButtonTapped()
    func tableCellTapped(_ movie: Movie)
}

final class DefaultMovieListPresenter {
    
    // MARK: - Public properties
    unowned let view: MovieListView
    var showAddMoviePage: (() -> Void)?
    var showMovieDetailPage: ((Movie) -> Void)?
    
    init(view: MovieListView) {
        self.view = view
    }
}

// MARK: - MovieListPresenter
extension DefaultMovieListPresenter: MovieListPresenter {
    
    func getMovies() {
        let operationResult = CoreDataManager.instance.getUsers()
        
        switch operationResult {
        case .success(let movies):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view.updateMovieListView(movies: movies)
            }
        case .failure(let failure):
            print(failure)// Уведомление //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        }
    }
    
    func addMovieButtonTapped() {
        showAddMoviePage?()
    }
    
    func tableCellTapped(_ movie: Movie) {
        showMovieDetailPage?(movie)
    }
}
