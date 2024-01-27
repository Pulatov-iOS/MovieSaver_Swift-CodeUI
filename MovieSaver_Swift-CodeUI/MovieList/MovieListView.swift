
import UIKit

final class MovieListView: UIViewController {
    
    // MARK: - Public properties
    var presenter: MovieListPresenter!
    
    // MARK: - Private properties
    private let tableView = UITableView()
    private let titleName = "My Movie List"
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        addSubiews()
//        configConstraint()
        configUI()
    }
    
    // MARK: - Helpers
    private func addSubiews() {
        view.addSubview(tableView)
    }
    
    private func configUI() {
        title = titleName
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(resource: .movieListViewBackground)
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

// MARK: - Table ViewDelegate/DataSource
extension MovieListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! MovieTableViewCell
            
        return cell
    }
}
