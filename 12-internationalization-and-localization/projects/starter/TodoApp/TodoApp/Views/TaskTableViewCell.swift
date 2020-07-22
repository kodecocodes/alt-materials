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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class TaskTableViewCell: UITableViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    setupConstrainsts()
  }
  
  private func setupConstrainsts() {
    contentView.addSubview(taskNameLabel)
    contentView.addSubview(favoriteButton)
    
    taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
    favoriteButton.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      favoriteButton.leftAnchor.constraint(
        equalTo: contentView.leftAnchor,
        constant: 20),
      favoriteButton.centerYAnchor.constraint(
        equalTo: contentView.centerYAnchor),
      
      taskNameLabel.leftAnchor.constraint(
        equalTo: favoriteButton.rightAnchor,
        constant: 20),
      taskNameLabel.rightAnchor.constraint(
        lessThanOrEqualTo: contentView.rightAnchor,
        constant: -20),
      taskNameLabel.centerYAnchor.constraint(
        equalTo: contentView.centerYAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  lazy var favoriteButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "star-icon"), for: .normal)
    return button
  }()
  
  lazy var taskNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14.0)
    label.numberOfLines = 0
    
    return label
  }()

  func configure(_ task: Task){
    taskNameLabel.text = task.name
    accessoryType = task.isDone ? .checkmark : .none
    let image = task.isFavorited ? "star-icon" : "star-icon-filled"
    favoriteButton.setImage(UIImage(named: image), for: .normal)
  }
}
