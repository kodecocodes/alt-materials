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

enum BorderShape: String {
  case circle
  case squircle
  case none
}

final class ProfileImageView: UIImageView {
  // MARK: - Properties
  let boldBorder: Bool
  
  var hasBorder: Bool = false {
    didSet {
      guard hasBorder else { return layer.borderWidth = 0 }
      layer.borderWidth = boldBorder ? 10 : 2
    }
  }
  
  private let borderShape: BorderShape
  
  // MARK: - Initializers
  convenience init() {
    self.init(borderShape: .none)
  }
  
  init(borderShape: BorderShape, boldBorder: Bool = false) {
    self.borderShape = borderShape
    self.boldBorder = boldBorder
    super.init(frame: CGRect.zero)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    borderShape = .none
    boldBorder = false
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    backgroundColor = .lightGray
    contentMode = .scaleAspectFit
    clipsToBounds = true
//    layer.masksToBounds = true
  }
  
  // MARK: - Layouts
  override func layoutSubviews() {
    super.layoutSubviews()
    setupBorderShape()
  }
  
  private func setupBorderShape() {
    hasBorder = borderShape != .none
    let width = bounds.size.width
    let divisor: CGFloat
    switch borderShape {
    case .circle:
      divisor = 2
    case .squircle:
      divisor = 4
    case .none:
      divisor = width
    }
    let cornerRadius = width / divisor
    layer.cornerRadius = cornerRadius
  }
}
