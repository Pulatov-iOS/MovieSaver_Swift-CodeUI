protocol AddMovieNamePresenter: AnyObject {
    func saveMovieNameButtonTapped(nameMovie: String)
    func setMovieName(_ nameMovie: String)
}

final class DefaultAddMovieNamePresenter {
    
    // MARK: - Public properties
    unowned let view: AddMovieNameView
    var savedMovieName: ((String) -> Void)?
    var closeAddMovieNameScreen: (() -> Void)?
    
    init(view: AddMovieNameView) {
        self.view = view
    }
}

// MARK: - AddMovieNamePresenter
extension DefaultAddMovieNamePresenter: AddMovieNamePresenter {
    
    func saveMovieNameButtonTapped(nameMovie: String) {
        if !nameMovie.isEmpty {
            savedMovieName?(nameMovie)
            closeAddMovieNameScreen?()
        } else {
            view.showErrorAlert(error: "Enter the movie title.")
        }
    }
    
    func setMovieName(_ nameMovie: String) {
        view.updateTextField(nameMovie)
    }
}
