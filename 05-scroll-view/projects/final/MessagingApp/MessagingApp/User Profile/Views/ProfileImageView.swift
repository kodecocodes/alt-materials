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

final class ProfileImageView: UIImageView {
  // MARK: - Value Types
  enum BorderShape: String {
    case circle
    case squircle
    case square
    case none
  }
  
  // MARK: - Properties
  var hasBorder: Bool = false {
    didSet {
      layer.borderWidth = hasBorder ? 10 : 0
    }
  }
  
  private let borderShape: BorderShape
  
  // MARK: - Initializers
  init(borderShape: BorderShape) {
    self.borderShape = borderShape
    super.init(frame: CGRect.zero)
    layer.masksToBounds = true
    setupBorderShape()
  }
  
  convenience init() {
    self.init(borderShape: .none)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  // MARK: - Layouts
  private func setupBorderShape() {
    let hasBorder = borderShape != .none
    let borderWidth: CGFloat = hasBorder ? 10 : 0
    layer.borderWidth = borderWidth
    let width = bounds.size.width
    let divisor: CGFloat
    switch borderShape {
    case .circle:
      divisor = 2
    case .squircle:
      divisor = 4
    case .square, .none:
      divisor = width
    }
    let cornerRadius = width / divisor
    layer.cornerRadius = cornerRadius
  }
}
