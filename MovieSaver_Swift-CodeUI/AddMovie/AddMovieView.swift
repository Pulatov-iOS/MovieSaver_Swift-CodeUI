import UIKit

protocol AddMovieView: AnyObject {
    func updateData(image: UIImage)
}

enum PickerType {
    case camera
    case photoLibrary
}

enum MovieInformationType {
    case movieName
    case movieRating
    case movieReleaseDate
    case movieYouTubeLink
}

final class DefaultAddMovieView: UIViewController {
    
    // MARK: - Public properties
    var presenter: AddMoviePresenter!
    
    // MARK: - Private properties
    private let titleName = "Add new"
    private let scrollView = UIScrollView()
    
    private let addImageButtonBackgroundView = UIView()
    private let addImageButtomImageView = UIImageView()
    private var imageViewWidthConstraint: NSLayoutConstraint!
    private var imageViewHeightConstraint: NSLayoutConstraint!
    private let addImageButton = UIButton()
    
    private let stackView = UIStackView()
    private let movieNameLabel = UILabel()
    private let movieRatingLabel = UILabel()
    private let movieReleaseDateLabel = UILabel()
    private let movieYouTubeLinkLabel = UILabel()
    
    private let descriptionTitleLabel = UILabel()
    private let descriptionTextView = UITextView()
    private var bottomTextViewConstraint: NSLayoutConstraint!
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureConstraints()
        configureUI()
        saveMovieButtonAddToScreen()
        moveContentForKeyboard()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubview(scrollView)
        addSubviews([addImageButtonBackgroundView, stackView, descriptionTitleLabel, descriptionTextView], to: scrollView)
        addSubviews([addImageButtomImageView, addImageButton], to: addImageButtonBackgroundView)
        
        let topHorizontalStackView = createHorizontalStackView(firstMovieInformationType: .movieName, secondMovieInformationType: .movieRating)
        stackView.addArrangedSubview(topHorizontalStackView)
        let bottomHorizontalStackView = createHorizontalStackView(firstMovieInformationType: .movieReleaseDate, secondMovieInformationType: .movieYouTubeLink)
        stackView.addArrangedSubview(bottomHorizontalStackView)
    }
    
    private func addSubviews(_ subviews: [UIView], to containerView: UIView) {
        for subview in subviews {
            containerView.addSubview(subview)
        }
    }
    
    private func configureConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addImageButtonBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addImageButtomImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewWidthConstraint = addImageButtomImageView.widthAnchor.constraint(equalToConstant: 70)
        imageViewHeightConstraint = addImageButtomImageView.heightAnchor.constraint(equalToConstant: 70)
        bottomTextViewConstraint = descriptionTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -47)
        bottomTextViewConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addImageButtonBackgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            addImageButtonBackgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 27),
            addImageButtonBackgroundView.widthAnchor.constraint(equalToConstant: 150),
            addImageButtonBackgroundView.heightAnchor.constraint(equalToConstant: 150),
            
            addImageButtomImageView.centerXAnchor.constraint(equalTo: addImageButtonBackgroundView.centerXAnchor),
            addImageButtomImageView.centerYAnchor.constraint(equalTo: addImageButtonBackgroundView.centerYAnchor),
            imageViewWidthConstraint,
            imageViewHeightConstraint,
            
            addImageButton.centerXAnchor.constraint(equalTo: addImageButtonBackgroundView.centerXAnchor),
            addImageButton.centerYAnchor.constraint(equalTo: addImageButtonBackgroundView.centerYAnchor),
            addImageButton.widthAnchor.constraint(equalToConstant: 150),
            addImageButton.heightAnchor.constraint(equalToConstant: 150),
            
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 209),
            
            descriptionTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 443),
            descriptionTitleLabel.widthAnchor.constraint(equalToConstant: 311),
            
            descriptionTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 480),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 311),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 145)
        ])
    }
    
    private func configureUI() {
        title = titleName
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(resource: .addMovieBackground)
        scrollView.showsVerticalScrollIndicator = false
        
        addImageButtonBackgroundView.layer.cornerRadius = 75
        addImageButtonBackgroundView.backgroundColor = UIColor(resource: .addImageButtonBackground)
        addImageButtomImageView.image = UIImage(resource: .addMovieButton)
        addImageButton.layer.cornerRadius = 75
        addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 32
        
        descriptionTitleLabel.text = "Description"
        descriptionTitleLabel.textAlignment = .center
        descriptionTitleLabel.font = .manrope(ofSize: 18, style: .medium)
        
        descriptionTextView.text = "With Spider-Man's identity now revealed, Peter asks Doctor Strange..."
        descriptionTextView.font = .manrope(ofSize: 14, style: .regular)
    }
    
    private func createHorizontalStackView(firstMovieInformationType: MovieInformationType, secondMovieInformationType: MovieInformationType) -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.spacing = 45
        
        let firstMovieInformationView = createMovieInformationView(firstMovieInformationType)
        horizontalStackView.addArrangedSubview(firstMovieInformationView)
        
        let secondMovieInformationView = createMovieInformationView(secondMovieInformationType)
        horizontalStackView.addArrangedSubview(secondMovieInformationView)
        
        return horizontalStackView
    }
    
    private func createMovieInformationView(_ movieInformationType: MovieInformationType) -> UIView {
        
        let title: String
        let movieInformationLabel: UILabel
        let heightView: CGFloat
        let buttonTappedSelector: Selector
        
        switch movieInformationType {
        case .movieName:
            title = "Name"
            movieInformationLabel = movieNameLabel
            heightView = 84
            buttonTappedSelector = #selector(addMovieNameButtonTapped)
        case .movieRating:
            title = "Your Rating"
            movieInformationLabel = movieRatingLabel
            heightView = 84
            buttonTappedSelector = #selector(addMovieRatingButtonTapped)
        case .movieReleaseDate:
            title = "Release Date"
            movieInformationLabel = movieReleaseDateLabel
            heightView = 82
            buttonTappedSelector = #selector(addMovieReleaseDateButtonTapped)
        case .movieYouTubeLink:
            title = "YouTube Link"
            movieInformationLabel = movieYouTubeLinkLabel
            heightView = 82
            buttonTappedSelector = #selector(addMovieYouTubeLinkButtonTapped)
        }
        
        let view = UIView()
        let titleLabel = UILabel()
        let addInformationButton = UIButton(type: .system)
        
        addSubviews([titleLabel, movieInformationLabel, addInformationButton], to: view)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        addInformationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 125),
            view.heightAnchor.constraint(equalToConstant: heightView),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            titleLabel.widthAnchor.constraint(equalToConstant: 125),
            
            movieInformationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieInformationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movieInformationLabel.widthAnchor.constraint(equalToConstant: 125),
            
            addInformationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addInformationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            addInformationButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        titleLabel.text = title
        titleLabel.font = .manrope(ofSize: 18, style: .medium)
        titleLabel.textAlignment = .center
        
        movieInformationLabel.text = "-"
        movieInformationLabel.font = .manrope(ofSize: 18, style: .medium)
        movieInformationLabel.textAlignment = .center
        
        addInformationButton.setTitle("Change", for: .normal)
        addInformationButton.titleLabel?.font = .manrope(ofSize: 18, style: .medium)
        addInformationButton.addTarget(self, action: buttonTappedSelector, for: .touchUpInside)
        
        return view
    }
    
    private func saveMovieButtonAddToScreen() {
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        saveButton.addTarget(self, action: #selector(saveMovieButtonTapped), for: .touchUpInside)
        
        let saveBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc func addImageButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.showPicker(.camera)
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.showPicker(.photoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func showPicker(_ typeOfPicker: PickerType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        switch typeOfPicker {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func saveMovieButtonTapped() {
        
    }
    
    @objc func addMovieNameButtonTapped() {
        
    }
    
    @objc func addMovieRatingButtonTapped() {
        
    }
    
    @objc func addMovieReleaseDateButtonTapped() {
        
    }
    
    @objc func addMovieYouTubeLinkButtonTapped() {
      
    }
    
    private func moveContentForKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomTextViewConstraint.constant = -keyboardHeight
            let currentOffset = scrollView.contentOffset
            let newOffset = CGPoint(x: currentOffset.x, y: currentOffset.y + keyboardHeight - 100)
            
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                self.scrollView.setContentOffset(newOffset, animated: true)
                self.navigationController?.navigationBar.prefersLargeTitles = false
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardHide() {
        bottomTextViewConstraint.constant = -47
        
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - AddMovieView
extension DefaultAddMovieView: AddMovieView {
    
    func updateData(image: UIImage) {
        addImageButtomImageView.image = image
        
        imageViewWidthConstraint.constant = 150
        imageViewHeightConstraint.constant = 150
        addImageButtomImageView.layer.cornerRadius = 75
        addImageButtomImageView.clipsToBounds = true
        addImageButtomImageView.contentMode = .scaleAspectFill
    }
}

// MARK: - PickerDelegate
extension DefaultAddMovieView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.presenter.selectedMovieImage(image: image)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
