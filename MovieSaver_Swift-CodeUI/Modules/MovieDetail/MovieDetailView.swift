import UIKit
import WebKit

protocol MovieDetailView: AnyObject {
    func updateMovieView(movie: Movie)
}

final class DefaultMovieDetailView: UIViewController {
    
    // MARK: - Public properties
    var presenter: MovieDetailPresenter!
    
    // MARK: - Private properties
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let ratingContainerView = UIView()
    private let starImageView = UIImageView()
    private let ratingLabel = UILabel()
    private let yearLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let webBackgroundView = UIView()
    private let webLabel = UILabel()
    private let webView = WKWebView()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - Helpers
    private func addSubviews() {
        addSubviews([imageView, scrollView], to: view)
        scrollView.addSubview(containerView)
        addSubviews([titleLabel, ratingContainerView, descriptionLabel, webBackgroundView, webLabel, webView], to: containerView)
        addSubviews([starImageView, ratingLabel, yearLabel], to: ratingContainerView)
    }
    
    private func addSubviews(_ subviews: [UIView], to containerView: UIView) {
        for subview in subviews {
            containerView.addSubview(subview)
        }
    }
    
    private func configureConstraints() {
        [imageView, scrollView, containerView, titleLabel, ratingContainerView, starImageView, ratingLabel, yearLabel, descriptionLabel, webBackgroundView, webLabel, webView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constant = view.bounds.height * 0.31
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.36),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: constant),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 29),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 19),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 18),
            
            ratingContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            ratingContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 19),
            ratingContainerView.widthAnchor.constraint(equalToConstant: 124),
            ratingContainerView.heightAnchor.constraint(equalToConstant: 24),
            
            starImageView.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: ratingContainerView.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 11),
            
            yearLabel.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 6),
            
            descriptionLabel.topAnchor.constraint(equalTo: ratingContainerView.bottomAnchor, constant: 13),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 19),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 19),
            
            webBackgroundView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            webBackgroundView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            webBackgroundView.widthAnchor.constraint(equalToConstant: 338),
            webBackgroundView.heightAnchor.constraint(equalToConstant: 196),
            webBackgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -52),
            
            webLabel.centerXAnchor.constraint(equalTo: webBackgroundView.centerXAnchor),
            webLabel.centerYAnchor.constraint(equalTo: webBackgroundView.centerYAnchor),
            
            webView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            webView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            webView.widthAnchor.constraint(equalToConstant: 338),
            webView.heightAnchor.constraint(equalToConstant: 196),
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -52)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .movieDetailBackground)
        
        containerView.backgroundColor = UIColor(resource: .movieDetailBackground)
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        starImageView.image = UIImage(resource: .star)
        
        webBackgroundView.backgroundColor = UIColor(resource: .webViewBackground)
        webLabel.text = "YouTube trailer"
        webLabel.font = .systemFont(ofSize: 15)
    }
}

// MARK: - MovieDetailView
extension DefaultMovieDetailView: MovieDetailView {
    
    func updateMovieView(movie: Movie) {
        if let dateImage = movie.image {
            if let image = UIImage(data: dateImage) {
                imageView.image = image
            }
        }
        
        titleLabel.text = movie.name ?? ""
        titleLabel.numberOfLines = 0
        titleLabel.font = .manrope(ofSize: 24, style: .bold)
        
        let text = "\(movie.rating)/10"
        let attributedRatingText = NSMutableAttributedString(string: text)
        let ratingRange = NSRange(location: 0, length: min(3, text.count))
        let totalRange = NSRange(location: ratingRange.length, length: text.count - ratingRange.length)
        attributedRatingText.addAttribute(.font, value: UIFont.manrope(ofSize: 14, style: .bold), range: ratingRange)
        attributedRatingText.addAttribute(.foregroundColor, value: UIColor.ratingFirstDetailTextLabel, range: ratingRange)
        attributedRatingText.addAttribute(.font, value: UIFont.manrope(ofSize: 14, style: .regular), range: totalRange)
        attributedRatingText.addAttribute(.foregroundColor, value: UIColor.ratingSecondDetailTextLabel, range: totalRange)
        ratingLabel.attributedText = attributedRatingText
        
        if let movieDate = movie.releaseDate {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: movieDate)
            yearLabel.text = "\(year)"
        } else {
            yearLabel.text = "None"
        }
        yearLabel.textColor = UIColor(resource: .yearTextLabel)
        yearLabel.font = .manrope(ofSize: 14, style: FontStyle.regular)
        
        descriptionLabel.text = movie.descriptions ?? ""
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .manrope(ofSize: 14, style: .regular)
        
        if let link = movie.link, movie.link != "" {
            if let url = URL(string: link) {
                webView.load(URLRequest(url: url))
                webView.allowsBackForwardNavigationGestures = true
            }
        } else {
            webView.isHidden = true
        }
    }
}
