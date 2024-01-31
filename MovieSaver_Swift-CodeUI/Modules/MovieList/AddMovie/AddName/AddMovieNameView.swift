import UIKit

protocol AddMovieNameView: AnyObject {
    func updateTextField(_ movieName: String)
    func showErrorAlert(error: String)
}

final class DefaultAddMovieNameView: UIViewController {
    
    // MARK: - Public properties
    var presenter: AddMovieNamePresenter!
    
    // MARK: - Private properties
    private let pageTitleLabel = UILabel()
    private let textField = UITextField()
    private let textFieldLineView = UIView()
    private let saveButton = UIButton(type: .system)
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureConstraints()
        configureUI()
        hideKeyboard()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubview(pageTitleLabel)
        view.addSubview(textField)
        view.addSubview(textFieldLineView)
        view.addSubview(saveButton)
    }
    
    private func configureConstraints() {
        [pageTitleLabel, textField, textFieldLineView, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            
            textField.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 42),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 326),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            textFieldLineView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            textFieldLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldLineView.widthAnchor.constraint(equalToConstant: 326),
            textFieldLineView.heightAnchor.constraint(equalToConstant: 1),
            
            saveButton.topAnchor.constraint(equalTo: textFieldLineView.bottomAnchor, constant: 42),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 79),
            saveButton.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        pageTitleLabel.text = "Film Name"
        pageTitleLabel.font = .manrope(ofSize: 24, style: .medium)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: attributes)
        
        textFieldLineView.backgroundColor = UIColor(resource: .divider)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .manrope(ofSize: 18, style: .medium)
        saveButton.addTarget(self, action: #selector(saveNameMovieButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveNameMovieButtonTapped() {
        presenter.saveMovieNameButtonTapped(nameMovie: textField.text ?? "")
    }
    
    private func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - AddMovieNameView
extension DefaultAddMovieNameView: AddMovieNameView {
    
    func updateTextField(_ movieName: String) {
        textField.text = movieName
    }
    
    func showErrorAlert(error: String) {
        let alert = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
