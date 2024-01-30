import CoreData
import UIKit.UIApplication

enum CoreDataError: Error {
    case error(String)
}

final class CoreDataManager {
    
    static let instance = CoreDataManager()
    private init() { }
    
    func saveMovie(moviedto: MovieDTO) -> Result<Void, CoreDataError> {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: manageContext)!
        let movie = NSManagedObject(entity: entity, insertInto: manageContext)
        
        movie.setValue(moviedto.name, forKey: "name")
        movie.setValue(moviedto.rating, forKey: "rating")
        movie.setValue(moviedto.releaseDate, forKey: "releaseDate")
        movie.setValue(moviedto.link, forKey: "link")
        movie.setValue(moviedto.descriptions, forKey: "descriptions")
        movie.setValue(moviedto.image, forKey: "image")
 
        do {
            try manageContext.save()
        } catch {
            return .failure(.error("Could not save. \(error)"))
        }
        
        return .success(())
    }
    
    func getUsers() -> Result<[Movie], CoreDataError> {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")

        let movies: [Movie]
        
        do {
            let objects = try manageContext.fetch(fetchRequest)
            guard let fetchedMovie = objects as? [Movie] else {
                return .failure(.error("Could not cast as [Movie]"))
            }
            movies = fetchedMovie
        } catch {
            return .failure(.error("Could not fetch \(error)"))
        }
        
        return .success(movies)
    }
}
