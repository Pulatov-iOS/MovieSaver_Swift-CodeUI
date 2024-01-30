import UIKit

protocol MovieListView: AnyObject {
    func updateMovieListView(movies: String)
}

final class DefaultMovieListView: UIViewController {
    
    // MARK: - Public properties
    var presenter: MovieListPresenter!
    
    // MARK: - Private properties
    private let tableView = UITableView()
    private let titleName = "My Movie List"
    private let heightTableCell = 212
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureUI()
        setupTableView()
        addMovieButtonAddToScreen()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func configureUI() {
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
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    private func addMovieButtonAddToScreen() {
        let addMovieButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovieButtonTapped))
        navigationItem.rightBarButtonItem = addMovieButton
    }
    
    @objc private func addMovieButtonTapped() {
        presenter.addMovieButtonTapped()
    }
}

// MARK: - MovieListView
extension DefaultMovieListView: MovieListView {
    
    func updateMovieListView(movies: String) {
        
    }
}

// MARK: - Table ViewDelegate/DataSource
extension DefaultMovieListView: UITableViewDelegate, UITableViewDataSource {
    
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
extension DefaultMovieListView: MovieTableViewCellDelegate {
    
    func didSelectCell(_ cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
    }
}
