import Foundation

protocol AddMoviePresenter: AnyObject {
    func saveMovieButtonTapped()
    func addMovieNameButtonTapped()
    func addMovieRatingButtonTapped()
    func addMovieReleaseDateButtonTapped()
    func addMovieLinkButtonTapped()
    func selectedMovieImage(imageData: Data)
    func updateMovieName(movieName: String)
    func updateMovieRating(movieRating: Double)
    func updateMovieReleaseDate(movieReleaseDate: Date)
    func updateMovieLink(movieLink: String)
    func updateMovieDescription(movieDescription: String)
}

enum MovieParameters {
    case name
    case rating
    case releaseDate
}

final class DefaultAddMoviePresenter {
    
    // MARK: - Public properties
    unowned let view: AddMovieView
    var showAddMovieNamePage: ((String) -> Void)?
    var showAddMovieRatingPage: ((Double) -> Void)?
    var showAddMovieReleaseDatePage: ((Date) -> Void)?
    var showAddMovieLinkPage: ((String) -> Void)?
    var closeAddMovieScreen: (() -> Void)?
    
    // MARK: - Private properties
    private var moviedto = MovieDTO(name: "", rating: 5.0, releaseDate: Date(), link: "", descriptions: "", image: Data())
    private var allMovieParametersFilled: [MovieParameters] = []
    
    init(view: AddMovieView) {
        self.view = view
    }
    
    private func createErrorAlertMessage() -> String {
        var message = "Enter the "
        if !allMovieParametersFilled.contains(.name) {
            message += "name"
        }
        if !allMovieParametersFilled.contains(.rating) {
            if allMovieParametersFilled.contains(.name) {
                message += "rating"
            } else {
                if allMovieParametersFilled.contains(.releaseDate) {
                    message += "and rating"
                } else { message += ", rating" }
            }
        }
        if !allMovieParametersFilled.contains(.releaseDate) {
            if allMovieParametersFilled.contains(.name) && allMovieParametersFilled.contains(.rating) {
                message += "release date"
            } else { message += " and release date" }
        }
        message += " of the movie."
        return message
    }
}

// MARK: - AddMoviePresenter
extension DefaultAddMoviePresenter: AddMoviePresenter {
    
    func saveMovieButtonTapped() {
        if allMovieParametersFilled.count == 3 {
            let result = CoreDataManager.instance.saveMovie(moviedto: moviedto)
            switch result {
            case .success(_):
                closeAddMovieScreen?()
            case .failure(let failure):
                view.showErrorAlert(error: failure.localizedDescription)
            }
        } else {
            view.showErrorAlert(error: createErrorAlertMessage())
        }
    }
    
    func addMovieNameButtonTapped() {
        showAddMovieNamePage?(moviedto.name)
    }
    
    func addMovieRatingButtonTapped() {
        showAddMovieRatingPage?(moviedto.rating)
    }
    
    func addMovieReleaseDateButtonTapped() {
        showAddMovieReleaseDatePage?(moviedto.releaseDate)
    }
    
    func addMovieLinkButtonTapped() {
        showAddMovieLinkPage?(moviedto.link)
    }
    
    func selectedMovieImage(imageData: Data) {
        moviedto.image = imageData
        view.updateMovieImageView(imageData)
    }
    
    func updateMovieName(movieName: String) {
        moviedto.name = movieName
        if !movieName.isEmpty {
            if !allMovieParametersFilled.contains(.name) {
                allMovieParametersFilled.append(.name)
            }
        } else {
            allMovieParametersFilled = allMovieParametersFilled.filter { $0 != .name }
        }
        view.updateMovieNameLabel(movieName)
    }
    
    func updateMovieRating(movieRating: Double) {
        moviedto.rating = movieRating
        if !allMovieParametersFilled.contains(.rating) {
            allMovieParametersFilled.append(.rating)
        }
        view.updateMovieRatingLabel(movieRating)
    }
    
    func updateMovieReleaseDate(movieReleaseDate: Date) {
        moviedto.releaseDate = movieReleaseDate
        if !allMovieParametersFilled.contains(.releaseDate) {
            allMovieParametersFilled.append(.releaseDate)
        }
        view.updateMovieReleaseDateLabel(movieReleaseDate)
    }
    
    func updateMovieLink(movieLink: String) {
        moviedto.link = movieLink
        view.updateMovieLinkLabel(movieLink)
    }
    
    func updateMovieDescription(movieDescription: String) {
        moviedto.descriptions = movieDescription
    }
}
