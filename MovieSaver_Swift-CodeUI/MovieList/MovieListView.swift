
import UIKit

final class MovieListView: UIViewController {
    
    // MARK: - Public properties
    var presenter: MovieListPresenter!
    
    // MARK: - Private properties
    private let tableView = UITableView()
    private let titleName = "My Movie List"
    private let heightTableCell = 212
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubiews()
        configUI()
        setupTableView()
        addMovieButton()
    }
    
    // MARK: - Helpers
    private func addSubiews() {
        view.addSubview(tableView)
    }
    
    private func configUI() {
        title = titleName
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(resource: .movieListViewBackground)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 22, right: 0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    private func addMovieButton() {
        let addMovieButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovieButtonTapped))
        navigationItem.rightBarButtonItem = addMovieButton
    }
    
    @objc private func addMovieButtonTapped() {

    }
}

// MARK: - Table ViewDelegate/DataSource
extension MovieListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! MovieTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightTableCell)
    }
}

// MARK: - MovieTableViewCellDelegate
extension MovieListView: MovieTableViewCellDelegate {
    
    func didSelectCell(_ cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
    }
}
