import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func didSelectCell(_ cell: MovieTableViewCell)
}

final class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    private let containerView = UIView()
    private let movieImageView = UIImageView()
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    
    weak var delegate: MovieTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
        configureUI()
        cellTappedHandler()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(movieImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(ratingLabel)
    }
    
    private func configureConstraints() {
        [containerView, movieImageView, nameLabel, ratingLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.59),
            
            nameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 34),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            ratingLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 30),
            ratingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 138),
            ratingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -29)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        containerView.backgroundColor = .cellBackground
        containerView.layer.shadowColor = UIColor.cellShadow.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 16
        containerView.layer.cornerRadius = 8
        
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 8
        movieImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func setInformation(movie: Movie?) {
        if let dateImage = movie?.image {
            if let image = UIImage(data: dateImage) {
                movieImageView.image = image
            }
        }
        
        nameLabel.text = movie?.name ?? ""
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 3
        nameLabel.font = .manrope(ofSize: 18, style: .medium)
        
        let text = ("\(movie?.rating ?? 0.0)/10")
        let attributedRatingText = NSMutableAttributedString(string: text)
        let ratingRange = NSRange(location: 0, length: min(3, text.count))
        let totalRange = NSRange(location: ratingRange.length, length: text.count - ratingRange.length)
        attributedRatingText.addAttribute(.font, value: UIFont.manrope(ofSize: 18, style: .bold), range: ratingRange)
        attributedRatingText.addAttribute(.foregroundColor, value: UIColor.ratingFirstTextLabel, range: ratingRange)
        attributedRatingText.addAttribute(.font, value: UIFont.manrope(ofSize: 18, style: .regular), range: totalRange)
        attributedRatingText.addAttribute(.foregroundColor, value: UIColor.ratingSecondTextLabel, range: totalRange)
        ratingLabel.attributedText = attributedRatingText
        ratingLabel.textAlignment = .center
    }
    
    private func cellTappedHandler() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellTapped() {
         delegate?.didSelectCell(self)
     }
}
