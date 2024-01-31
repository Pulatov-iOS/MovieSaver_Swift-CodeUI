import Foundation

protocol AddMovieReleaseDatePresenter: AnyObject {
    func saveMovieReleaseDateButtonTapped(releaseDateMovie: Date)
    func setMovieReleaseDate(_ releaseDateMovie: Date)
}

final class DefaultAddMovieReleaseDatePresenter {
    
    // MARK: - Public properties
    unowned let view: AddMovieReleaseDateView
    var savedMovieReleaseDate: ((Date) -> Void)?
    var closeAddMovieReleaseDateScreen: (() -> Void)?
    
    init(view: AddMovieReleaseDateView) {
        self.view = view
    }
}

// MARK: - AddMovieReleaseDatePresenter
extension DefaultAddMovieReleaseDatePresenter: AddMovieReleaseDatePresenter {
    
    func saveMovieReleaseDateButtonTapped(releaseDateMovie: Date) {
        savedMovieReleaseDate?(releaseDateMovie)
        closeAddMovieReleaseDateScreen?()
    }
    
    func setMovieReleaseDate(_ releaseDateMovie: Date) {
        view.updateDatePickerView(releaseDateMovie)
    }
}
