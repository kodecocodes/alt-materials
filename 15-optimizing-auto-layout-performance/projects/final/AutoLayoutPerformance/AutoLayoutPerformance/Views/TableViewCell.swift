/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

final class TableViewCell: UITableViewCell {
  // MARK: - Properties
  private var beverage: Beverage? {
    didSet {
      guard let beverage = beverage else { return }
      profileImageView.image = UIImage(named: beverage.username)
      postImageView.image = UIImage(named: beverage.name)
      usernameLabel.text = "@\(beverage.username)"
      titleLabel.text = "\(beverage.name)"
      cakeImageView.isHidden = !beverage.isHighCalorie
      isHighCalorieLabel.isHidden = !beverage.isHighCalorie
      badgeImageView.isHidden = !beverage.isFrequentUser
      setNeedsUpdateConstraints()
    }
  }
  
  private var staticConstraints: [NSLayoutConstraint] = []
  private var dynamicConstraints: [NSLayoutConstraint] = []
  
  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.text = "@username"
    return label
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.text = "title"
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non consectetur a erat nam at lectus urna duis convallis. Non odio euismod lacinia at. Viverra mauris in aliquam sem fringilla ut morbi tincidunt augue. Tincidunt eget nullam non nisi est sit amet facilisis."
    return label
  }()
  
  private let isHighCalorieLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.isHidden = true
    label.text = "High in calories."
    return label
  }()
  
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .secondarySystemFill
    return imageView
  }()
  
  private let postImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let cakeImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "cake"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    return imageView
  }()
  
  private let badgeImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "badge"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  // MARK: - Computed Properties
  private var profileConstraints: [NSLayoutConstraint] {
    profileImageViewConstraints + badgeImageViewConstraints
  }
  
  private var profileImageViewConstraints: [NSLayoutConstraint] {
    [profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
    profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
    profileImageView.heightAnchor.constraint(equalToConstant: 60),
    profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)]
  }
  
  private var badgeImageViewConstraints: [NSLayoutConstraint] {
    [badgeImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
    badgeImageView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
    badgeImageView.heightAnchor.constraint(equalTo: profileImageView.heightAnchor),
    badgeImageView.widthAnchor.constraint(equalTo: profileImageView.widthAnchor)]
  }
  
  private var usernameLabelConstraints: [NSLayoutConstraint] {
    [usernameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
     usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
     usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)]
  }
  
  private var titleLabelConstraints: [NSLayoutConstraint] {
    [titleLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
     titleLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
     titleLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor)]
  }
  
  private var descriptionLabelConstraints: [NSLayoutConstraint] {
    [descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
     descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
     descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)]
  }
  
  private var postImageViewConstraints: [NSLayoutConstraint] {
    [postImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
     postImageView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
     postImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)]
  }
  
  private var highCalorieConstraints: [NSLayoutConstraint] {
    [cakeImageView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 4),
     cakeImageView.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor),
     cakeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
     cakeImageView.widthAnchor.constraint(equalToConstant: 32),
     cakeImageView.widthAnchor.constraint(equalTo: cakeImageView.heightAnchor),
     isHighCalorieLabel.leadingAnchor.constraint(equalTo: cakeImageView.trailingAnchor, constant: 8),
     isHighCalorieLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
     isHighCalorieLabel.centerYAnchor.constraint(equalTo: cakeImageView.centerYAnchor)]
  }
  
  private var lowCalorieConstraints: [NSLayoutConstraint] {
    [postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)]
  }
  
  // MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    contentView.addSubview(usernameLabel)
    contentView.addSubview(titleLabel)
    contentView.addSubview(profileImageView)
    contentView.addSubview(badgeImageView)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(postImageView)
    contentView.addSubview(cakeImageView)
    contentView.addSubview(isHighCalorieLabel)
  }
  
  // MARK: - Configurations
  func configureCell(beverage: Beverage) {
    self.beverage = beverage
  }
  
  // MARK: - Constraints
  override func updateConstraints() {
    print("Update constraints")
    if staticConstraints.isEmpty {
      staticConstraints =
        usernameLabelConstraints
        + titleLabelConstraints
        + profileConstraints
        + descriptionLabelConstraints
        + postImageViewConstraints
      NSLayoutConstraint.activate(staticConstraints)
    }
    
    if beverage?.isHighCalorie ?? false
      && dynamicConstraints != highCalorieConstraints {
      updateDynamicConstraints(isHighCalorie: true)
    } else if dynamicConstraints != lowCalorieConstraints {
      updateDynamicConstraints(isHighCalorie: false)
    }
    super.updateConstraints()
  }
  
  private func updateDynamicConstraints(isHighCalorie: Bool) {
    NSLayoutConstraint.deactivate(dynamicConstraints)
    dynamicConstraints = isHighCalorie
      ? highCalorieConstraints : lowCalorieConstraints
    NSLayoutConstraint.activate(dynamicConstraints)
  }
}
