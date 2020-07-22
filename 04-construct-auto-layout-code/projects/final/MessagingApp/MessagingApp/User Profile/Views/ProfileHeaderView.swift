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

final class ProfileHeaderView: UIView {
  // MARK: - Properties
  private let profileImageView =
    ProfileImageView(borderShape: .squircle)
  private let leftSpacerView = UIView()
  private let rightSpacerView = UIView()

  private let fullNameLabel = ProfileNameLabel()
  
  private let messageButton =
    UIButton.createSystemButton(withTitle: "Message")
  private let callButton =
    UIButton.createSystemButton(withTitle: "Call")
  private let emailButton =
    UIButton.createSystemButton(withTitle: "Email")
  
  private lazy var profileImageStackView =
    UIStackView(arrangedSubviews:
      [leftSpacerView, profileImageView, rightSpacerView])

  private lazy var profileStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews:
      [profileImageStackView, fullNameLabel])
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.spacing = 16
    return stackView
  }()

  private lazy var actionStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews:
      [messageButton, callButton, emailButton])
    stackView.distribution = .fillEqually
    return stackView
  }()

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews:
      [profileStackView, actionStackView])
    stackView.axis = .vertical
    stackView.spacing = 16
    return stackView
  }()
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .groupTableViewBackground
    setupStackView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - Layouts
  private func setupStackView() {
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate(
      [stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
       stackView.leadingAnchor.constraint(
        greaterThanOrEqualTo: leadingAnchor, constant: 20),
       stackView.leadingAnchor.constraint(
        lessThanOrEqualTo: leadingAnchor, constant: 500),
       stackView.bottomAnchor.constraint(
        equalTo: bottomAnchor, constant: -8),
       stackView.topAnchor.constraint(
        equalTo: topAnchor, constant: 26),
       
       profileImageView.widthAnchor.constraint(
        equalToConstant: 120),
       profileImageView.widthAnchor.constraint(
        equalTo: profileImageView.heightAnchor),
       
       leftSpacerView.widthAnchor.constraint(
        equalTo: rightSpacerView.widthAnchor)
      ])
    
    profileImageView.setContentHuggingPriority(
      UILayoutPriority(251),
      for: NSLayoutConstraint.Axis.horizontal)
    profileImageView.setContentHuggingPriority(
      UILayoutPriority(251),
      for: NSLayoutConstraint.Axis.vertical)
    
    fullNameLabel.setContentHuggingPriority(
      UILayoutPriority(251),
      for: NSLayoutConstraint.Axis.horizontal)
    fullNameLabel.setContentHuggingPriority(
      UILayoutPriority(251),
      for: NSLayoutConstraint.Axis.vertical)
    fullNameLabel.setContentCompressionResistancePriority(
      UILayoutPriority(751),
      for: NSLayoutConstraint.Axis.vertical)
    
    messageButton.setContentCompressionResistancePriority(
      UILayoutPriority(751),
      for: NSLayoutConstraint.Axis.horizontal)
  }
}

private extension UIButton {
  static func createSystemButton(withTitle title: String)
    -> UIButton {
      let button = UIButton(type: .system)
      button.setTitle(title, for: .normal)
      return button
  }
}
