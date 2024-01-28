
protocol AddMoviePresenter: AnyObject {
    
}

final class DefaultAddMoviePresenter {
    
    unowned let view: AddMovieView
    
    init(view: AddMovieView) {
        self.view = view
    }
    
}

// MARK: - AddMoviePresenter
extension DefaultAddMoviePresenter: AddMoviePresenter {
    
}
