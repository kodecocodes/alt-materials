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

final class ContactPreviewView: UIView {
  // MARK: - Properties
  let photoImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "rw-logo"))
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textAlignment = .center
    return label
  }()
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(named: "rw-light")
    setupViewLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViewLayout()
  }
  
  // MARK: - Setup Views
  private func setupViewLayout() {
    addSubview(photoImageView)
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate(
      [photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
       photoImageView.widthAnchor.constraint(equalToConstant: 80),
       photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
       photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
       
       nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
       nameLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
       nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8)])
  }
}
