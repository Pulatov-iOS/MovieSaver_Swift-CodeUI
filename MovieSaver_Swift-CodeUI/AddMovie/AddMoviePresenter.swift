import UIKit.UIImage

protocol AddMoviePresenter: AnyObject {
    func selectedMovieImage(image: UIImage)
}

final class DefaultAddMoviePresenter {
    
    unowned let view: AddMovieView
    
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
}
