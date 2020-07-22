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

class MessagesViewController: UIViewController {
  private let defaultBackgroundColor = UIColor(
    red: 249/255.0,
    green: 249/255.0,
    blue: 249/255.0,
    alpha: 1)
  
  @IBOutlet weak var tableView: UITableView!
  
  private let toolbarView = ToolbarView()
  private var toolbarViewTopConstraint: NSLayoutConstraint!
  private var messages: [Message] = []
  
  var contact: Contact? {
    didSet {
      loadViewIfNeeded()
      messages = contact?.messages() ?? []
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = defaultBackgroundColor
    tableView.backgroundColor = defaultBackgroundColor
    
    setupToolbarView()
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(hideToolbarView))
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self
    tableView.addGestureRecognizer(gesture)
  }
  
  private func setupToolbarView() {
    view.addSubview(toolbarView)
    toolbarViewTopConstraint = toolbarView.topAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.topAnchor,
      constant: -100)
    toolbarViewTopConstraint.isActive = true
    
    toolbarView.leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: 30).isActive = true
    
    toolbarView.delegate = self
  }
  
  @objc func hideToolbarView() {
    self.toolbarViewTopConstraint.constant =  -100
    UIView.animate(
      withDuration: 1.0,
      delay: 0.0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 1,
      options: [],
      animations: {
        self.toolbarView.alpha = 0
        self.view.layoutIfNeeded()
    },completion: nil)
  }
}

//MARK: - Toolbar View Delegate
extension MessagesViewController: ToolbarViewDelegate {
  func toolbarView(_ toolbarView: ToolbarView, didFavoritedWith tag: Int) {
    messages[tag].isFavorited.toggle()
  }
  
  func toolbarView(_ toolbarView: ToolbarView, didLikedWith tag: Int) {
    messages[tag].isLiked.toggle()
  }
}

//MARK: - Gesture Delegate
extension MessagesViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return touch.view == tableView
  }
}

//MARK: - UITableView Delegate & Data Source
extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let message = messages[indexPath.row]
    
    let cellIdentifier = message.sentByMe ? "RightBubble" : "LeftBubble"
    
    let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier,
      for: indexPath) as! MessageBubbleTableViewCell
    cell.messageLabel.text = message.text
    cell.backgroundColor = defaultBackgroundColor
    
    if !message.sentByMe {
      cell.delegate = self
    }
    
    return cell
  }
}

//MARK: - Message Bubble Cell Delegate
extension MessagesViewController: MessageBubbleTableViewCellDelegate {
  func doubleTapForCell(_ cell: MessageBubbleTableViewCell) {
    self.toolbarViewTopConstraint.constant =  cell.frame.midY
    self.toolbarView.alpha = 0.95
    if let indexPath = self.tableView.indexPath(for: cell) {
      let message = messages[indexPath.row]
      self.toolbarView.update(isLiked: message.isLiked, isFavorited: message.isFavorited)
      self.toolbarView.tag = indexPath.row
    }
    
    UIView.animate(
      withDuration: 1.0,
      delay: 0.0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 1,
      options: [],
      animations: {
        self.view.layoutIfNeeded()
    }, completion: nil)
  }
}
