import Foundation
import UIKit

protocol AddMovieReleaseDateView: AnyObject {
    func updateDatePickerView(_ movieReleaseDate: Date)
}

final class DefaultAddMovieReleaseDateView: UIViewController {
    
    // MARK: - Public properties
    var presenter: AddMovieReleaseDatePresenter!
    
    // MARK: - Private properties
    private let pageTitleLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let saveButton = UIButton(type: .system)
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureConstraints()
        configureUI()
        setupTableView()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubview(pageTitleLabel)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }
    
    private func configureConstraints() {
        [pageTitleLabel, datePicker, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            
            datePicker.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 32),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 194),
            
            saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 32),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 79),
            saveButton.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        pageTitleLabel.text = "Release Date"
        pageTitleLabel.font = .manrope(ofSize: 24, style: .medium)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .manrope(ofSize: 18, style: .medium)
        saveButton.addTarget(self, action: #selector(saveReleaseDateMovieButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
    }
    
    @objc func saveReleaseDateMovieButtonTapped() {
        presenter.saveMovieReleaseDateButtonTapped(releaseDateMovie: datePicker.date)
    }
}

// MARK: - AddMovieReleaseDateView
extension DefaultAddMovieReleaseDateView: AddMovieReleaseDateView {
    
    func updateDatePickerView(_ movieReleaseDate: Date) {
        datePicker.date = movieReleaseDate
    }
}
