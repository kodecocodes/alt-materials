/// Copyright (c) 2019 Razeware LLC
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

// MARK: - Dictionaries
fileprivate let customFontSizeDictionary: [UIFont.TextStyle: CGFloat] =
  [.largeTitle: 34,
   .title1: 28,
   .title2: 22,
   .title3: 20,
   .headline: 17,
   .body: 17,
   .callout: 16,
   .subheadline: 15,
   .footnote: 13,
   .caption1: 12,
   .caption2: 11]

// MARK: - Value Types
enum FontWeight: String {
  case regular = "Regular"
  case bold = "Bold"
}

enum CustomFont: String {
  case avenirNext = "AvenirNext"
  case openDyslexic = "OpenDyslexic"
}

// MARK: - TableViewCell
final class TableViewCell: UITableViewCell {
  // MARK: - Properties
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var topStackView: UIStackView!
  @IBOutlet weak var profileImageStackView: UIStackView!
  
  @IBOutlet weak var profileImageViewWidthConstraint: NSLayoutConstraint!
  private let profileImageViewWidth: CGFloat = 32
  
  // MARK: - UI Changes
  func configureCell(text: String, index: Int, setCustomFont: Bool = false) {
    headerLabel.text = "\(index + 1). Header Title"
    descriptionLabel.text = text
    updateTraitCollectionLayout()
    guard setCustomFont else { return }
    setupDynamicCustomFont(.openDyslexic)
  }
  
  private func setupDynamicCustomFont(_ customFont: CustomFont) {
    headerLabel.set(customFont: customFont, fontWeight: .regular, textStyle: .title1)
    descriptionLabel.set(customFont: customFont, fontWeight: .regular)
  }
  
  // MARK: - Layouts
  func updateTraitCollectionLayout() {
    // 1
    let preferredContentSizeCategory =
      traitCollection.preferredContentSizeCategory
    // 2
    let scaledValue = UIFontMetrics.default
      .scaledValue(for: profileImageViewWidth)
    profileImageViewWidthConstraint.constant = scaledValue
    // 3
    topStackView.axis =
      preferredContentSizeCategory.isAccessibilityCategory
      ? .vertical : .horizontal
    // 4
    profileImageStackView.isHidden = preferredContentSizeCategory == .accessibilityExtraExtraExtraLarge
  }
}

// MARK: - UILabel
extension UILabel {
  func set(customFont: CustomFont, fontWeight: FontWeight, textStyle: UIFont.TextStyle = .body) {
    // 1
    let name = "\(customFont.rawValue)-\(fontWeight.rawValue)"
    guard let size = customFontSizeDictionary[textStyle] else { return }
    // 2
    guard let font = UIFont(name: name, size: size)
      else { fatalError("Retrieve \(name) with error.") }
    // 3
    let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
    self.font = fontMetrics.scaledFont(for: font)
    // 4
    adjustsFontForContentSizeCategory = true
  }
}
