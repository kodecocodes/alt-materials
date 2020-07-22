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

class LeftMessageBubbleTableViewCell: MessageBubbleTableViewCell {
  private let blueBubbleImageName = "blue-bubble"
  
  override func configureLayout() {
    super.configureLayout()
    NSLayoutConstraint.activate([
      //1
      contentView.topAnchor.constraint(equalTo: bubbleImageView.topAnchor, constant: -10),
      contentView.trailingAnchor.constraint(greaterThanOrEqualTo: bubbleImageView.trailingAnchor, constant: 20),
      contentView.bottomAnchor.constraint(equalTo: bubbleImageView.bottomAnchor, constant: 10),
      contentView.leadingAnchor.constraint(equalTo: bubbleImageView.leadingAnchor, constant: -20),
      //2
      bubbleImageView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -5),
      bubbleImageView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 10),
      bubbleImageView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5),
      bubbleImageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -20)
    ])
    
    //3
    let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    //4
    let image = UIImage(named: blueBubbleImageName)!
      .imageFlippedForRightToLeftLayoutDirection()
    //5
    bubbleImageView.image = image.resizableImage(
      withCapInsets: insets, resizingMode: .stretch)
  }
}
