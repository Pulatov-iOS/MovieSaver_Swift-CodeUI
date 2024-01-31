protocol AddMovieLinkPresenter: AnyObject {
    func saveMovieLinkButtonTapped(linkMovie: String)
    func setMovieLink(_ linkMovie: String)
}

final class DefaultAddMovieLinkPresenter {
    
    // MARK: - Public properties
    unowned let view: AddMovieLinkView
    var savedMovieLink: ((String) -> Void)?
    var closeAddMovieLinkScreen: (() -> Void)?
    
    init(view: AddMovieLinkView) {
        self.view = view
    }
}

// MARK: - AddMovieLinkPresenter
extension DefaultAddMovieLinkPresenter: AddMovieLinkPresenter {
    
    func saveMovieLinkButtonTapped(linkMovie: String) {
        if !linkMovie.isEmpty {
            savedMovieLink?(linkMovie)
            closeAddMovieLinkScreen?()
        } else {
            view.showErrorAlert(error: "Enter the movie link.")
        }
    }
    
    func setMovieLink(_ linkMovie: String) {
        view.updateTextField(linkMovie)
    }
}
