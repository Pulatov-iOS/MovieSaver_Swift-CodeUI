import UIKit.UIImage

protocol AddMoviePresenter: AnyObject {
    func selectedMovieImage(image: UIImage)
    func saveMovieButtonTapped(moviedto: MovieDTO)
}

final class DefaultAddMoviePresenter {
    
    // MARK: - Public properties
    unowned let view: AddMovieView
    
    // MARK: - Private properties
    private var movieImage = UIImage()
    
    init(view: AddMovieView) {
        self.view = view
    }
    
}

// MARK: - AddMoviePresenter
extension DefaultAddMoviePresenter: AddMoviePresenter {
    
    func selectedMovieImage(image: UIImage) {
        movieImage = image // в объект Movie
        view.updateData(image: image)
    }
    
    func saveMovieButtonTapped(moviedto: MovieDTO) {
        let result = CoreDataManager.instance.saveMovie(moviedto: moviedto)
        
        switch result {
        case .success(let success):
            print() //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        case .failure(let failure):
            print() //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        }
    }
}
