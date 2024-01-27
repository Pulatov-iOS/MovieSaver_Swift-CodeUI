
import UIKit

final class MovieListView: UIViewController {
    
    // MARK: - Public properties
    var viewModel: MovieListViewModel!
    
    // MARK: - Private properties
    private let tableView = UITableView()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubiews()
        
//        configConstraint()
//        configUI()
    }
    
    // MARK: - Helpers
    private func addSubiews() {
        view.addSubview(tableView)
    }
}

// MARK: - Table ViewDelegate/DataSource
extension MovieListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
