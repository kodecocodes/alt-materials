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

protocol ToolbarViewDelegate {
  func toolbarView(_ toolbarView: ToolbarView, didFavoritedWith tag: Int)
  func toolbarView(_ toolbarView: ToolbarView, didLikedWith tag: Int)
}

class ToolbarView: UIView {
  var delegate: ToolbarViewDelegate?
  private let likeButton = UIButton(type: .custom)
  private let favoriteButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    alpha = 0.98
    backgroundColor = .white
    layer.cornerRadius = 10
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.5
    translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: 70),
      heightAnchor.constraint(equalToConstant: 30),
    ])
    
    let stackview = UIStackView()
    stackview.translatesAutoresizingMaskIntoConstraints = false
    stackview.distribution = .fillEqually
    stackview.axis = .horizontal
    stackview.spacing = 5
    
    
    let favoriteButtonImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
    favoriteButton.setImage(favoriteButtonImage, for: .normal)
    favoriteButton.tintColor = .orange
    favoriteButton.addTarget(self, action: #selector(didFavorited), for: .touchUpInside)
    

    let likeButtonImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
    likeButton.setImage(likeButtonImage, for: .normal)
    likeButton.tintColor = .red
    likeButton.addTarget(self, action: #selector(didLiked), for: .touchUpInside)
    
    stackview.addArrangedSubview(favoriteButton)
    stackview.addArrangedSubview(likeButton)
    
    addSubview(stackview)
    
    stackview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    stackview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    stackview.widthAnchor.constraint(equalToConstant: 65).isActive = true
    stackview.heightAnchor.constraint(equalToConstant: 25).isActive = true
  }
  
  func update(isLiked: Bool, isFavorited: Bool) {
    let likeButtonColor: UIColor = isLiked ? .red : .lightGray
    likeButton.tintColor = likeButtonColor
    
    let favoriteButtonColor: UIColor = isFavorited ? .orange : .lightGray
    favoriteButton.tintColor = favoriteButtonColor
  }
  
  func toogleLikeButton() {
    let color: UIColor = likeButton.tintColor == .red ? .lightGray : .red
    likeButton.tintColor = color
  }
  
  func toogleFavoriteButton() {
    let color: UIColor = favoriteButton.tintColor == .orange ? .lightGray : .orange
    favoriteButton.tintColor = color
  }
  
  @objc func didFavorited() {
    toogleFavoriteButton()
    delegate?.toolbarView(self, didFavoritedWith: tag)
  }
  
  @objc func didLiked() {
    toogleLikeButton()
    delegate?.toolbarView(self, didLikedWith: tag)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
