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

enum MessageBubbleCellType: String {
  case rightText
  case leftText
}

class MessageBubbleTableViewCell: UITableViewCell {
  let greenBubbleImageName = "green-bubble"
  let blueBubbleImageName = "blue-bubble"
  
  lazy var messageLabel: UILabel = {
    let messageLabel = UILabel(frame: .zero)
    messageLabel.textColor = .black
    messageLabel.font = UIFont.systemFont(ofSize: 13)
    messageLabel.numberOfLines = 0
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    return messageLabel
  }()
  
  internal var bubbleImageView: UIImageView = {
    let bubbleImageView = UIImageView(frame: .zero)
    bubbleImageView.contentMode = .scaleToFill
    bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
    return bubbleImageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureLayout()
  }
  
  func configureBubbleImage(imageName: String, insets: UIEdgeInsets) {
    //1
    let image = UIImage(named: imageName)!
    
    //2
    bubbleImageView.image = image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }
  
  func configureLayout() {
    /*
    contentView.addSubview(messageLabel)
    
    NSLayoutConstraint.activate([
      //1
      messageLabel.topAnchor.constraint(
        equalTo: contentView.topAnchor,
        constant: 10),
      
      messageLabel.rightAnchor.constraint(
        equalTo: contentView.rightAnchor,
        constant: -10),
      
      messageLabel.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor,
        constant: -10),
      
      messageLabel.leftAnchor.constraint(
        equalTo: contentView.leftAnchor,
        constant: 10)
    ])
     */
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }
}
