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

@IBDesignable final class ContactPreviewView: UIView {
  @IBOutlet weak var photoImageView: ProfileImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var callButton: UIButton!
  
  let nibName = "ContactPreviewView"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    loadView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadView()
  }
  
  func loadView() {
    let bundle = Bundle(for: ContactPreviewView.self)
    let nib = UINib(nibName: nibName, bundle: bundle)
    
    let view = nib.instantiate(withOwner: self).first as! UIView
    
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    setupLayoutInView(view)
    
    addSubview(view)
  }
  
  private func setupLayoutInView(_ view: UIView) {
    let layoutGuide = UILayoutGuide()
    view.addLayoutGuide(layoutGuide)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    callButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      callButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      callButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor)
    ])
    
    let margins = view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      layoutGuide.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
      layoutGuide.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      layoutGuide.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      layoutGuide.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
    ])
  }
}
