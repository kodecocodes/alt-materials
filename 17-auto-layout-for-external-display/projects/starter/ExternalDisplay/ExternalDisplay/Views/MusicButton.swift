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

// MARK: - Value Type
enum MusicGenre: String {
  case rock, jazz, pop, none
  
  var backgroundColor: UIColor {
    switch self {
    case .rock:
      return UIColor(red: 0.44, green: 0.06, blue: 0.10, alpha: 1)
    case .jazz:
      return UIColor(red: 0.43, green: 0.52, blue: 0.56, alpha: 1)
    case .pop:
      return UIColor(red: 0.57, green: 0.70, blue: 0.59, alpha: 1)
    case .none:
      return UIColor(red: 0.66, green: 0.15, blue: 0.57, alpha: 1)
    }
  }
  
  var uppercasedText: String {
    return rawValue.uppercased()
  }
}

// MARK: - MusicButton
final class MusicButton: UIButton {
  // MARK: - Properties
  var musicGenre: MusicGenre? {
    didSet {
      backgroundColor = musicGenre?.backgroundColor
      setTitle(musicGenre?.uppercasedText, for: .normal)
      titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
  }
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.masksToBounds = true
    setTitleColor(.white, for: .normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - Layouts
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.width / 5
  }
}
