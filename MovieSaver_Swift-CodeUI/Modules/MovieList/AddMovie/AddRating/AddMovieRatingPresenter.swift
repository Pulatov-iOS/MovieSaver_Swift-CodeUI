protocol AddMovieRatingPresenter: AnyObject {
    func saveMovieRatingButtonTapped(ratingMovie: Double)
    func setMovieRating(_ ratingMovie: Double)
}

final class DefaultAddMovieRatingPresenter {
    
    // MARK: - Public properties
    unowned let view: AddMovieRatingView
    var savedMovieRating: ((Double) -> Void)?
    var closeAddMovieRatingScreen: (() -> Void)?
    
    init(view: AddMovieRatingView) {
        self.view = view
    }
}

// MARK: - AddMovieRatingPresenter
extension DefaultAddMovieRatingPresenter: AddMovieRatingPresenter {
    
    func saveMovieRatingButtonTapped(ratingMovie: Double) {
        savedMovieRating?(ratingMovie)
        closeAddMovieRatingScreen?()
    }
    
    func setMovieRating(_ ratingMovie: Double) {
        view.updatePickerView(ratingMovie)
    }
}
