import UIKit

protocol AddMovieRatingView: AnyObject {
    func updatePickerView(_ movieRating: Double)
}

final class DefaultAddMovieRatingView: UIViewController {
    
    // MARK: - Public properties
    var presenter: AddMovieRatingPresenter!
    
    // MARK: - Private properties
    private var currentRating = 5.0
    private var setOfRatings: [Double] = []
    private let pageTitleLabel = UILabel()
    private let pickerView = UIPickerView()
    private let saveButton = UIButton(type: .system)
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureConstraints()
        configureUI()
        setupPickerView()
        createSetOfRatings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = setOfRatings.firstIndex(of: currentRating) {
            pickerView.selectRow(index, inComponent: 0, animated: true)
        } else {
            pickerView.selectRow(50, inComponent: 0, animated: true)
        }
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        view.addSubview(pageTitleLabel)
        view.addSubview(pickerView)
        view.addSubview(saveButton)
    }
    
    private func configureConstraints() {
        [pageTitleLabel, pickerView, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            
            pickerView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 32),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 131),
            
            saveButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 32),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 79),
            saveButton.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        pageTitleLabel.text = "Your Rating"
        pageTitleLabel.font = .manrope(ofSize: 24, style: .medium)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .manrope(ofSize: 18, style: .medium)
        saveButton.addTarget(self, action: #selector(saveRatingMovieButtonTapped), for: .touchUpInside)
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func createSetOfRatings() {
        var currentValue = 0.0
        let endValue = 10.0
        let step = 0.1
        let precision = 1
        
        while currentValue <= endValue {
            let roundedValue = (currentValue * pow(10.0, Double(precision))).rounded() / pow(10.0, Double(precision))
            setOfRatings.append(roundedValue)
            currentValue += step
        }
    }
    
    @objc func saveRatingMovieButtonTapped() {
        presenter.saveMovieRatingButtonTapped(ratingMovie: currentRating)
    }
}

// MARK: - PickerView Delegate/DataSource
extension DefaultAddMovieRatingView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return setOfRatings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(setOfRatings[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRating = setOfRatings[row]
    }
}

// MARK: - AddMovieRatingView
extension DefaultAddMovieRatingView: AddMovieRatingView {
    
    func updatePickerView(_ movieRating: Double) {
        currentRating = movieRating
    }
}
