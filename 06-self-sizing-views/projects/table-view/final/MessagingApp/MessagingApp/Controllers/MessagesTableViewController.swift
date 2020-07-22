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

class MessagesTableViewController: UITableViewController {
  private var messages = Message.fetchAll()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Messages"
    
    configureTableView()
  }
  
  private func configureTableView() {
    tableView.allowsSelection = false
    tableView.register(
      RightMessageBubbleTableViewCell.self,
      forCellReuseIdentifier: MessageBubbleCellType.rightText.rawValue)
    tableView.register(
      LeftMessageBubbleTableViewCell.self,
      forCellReuseIdentifier: MessageBubbleCellType.leftText.rawValue)
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
  }
  
  //MARK: - UITableView Delegate & Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //1
    let message = messages[indexPath.row]
    
    var cell: MessageBubbleTableViewCell
    if message.sentByMe {
      cell = tableView.dequeueReusableCell(
        withIdentifier: MessageBubbleCellType.rightText.rawValue,
        for: indexPath) as! RightMessageBubbleTableViewCell
    }
    else {
      cell = tableView.dequeueReusableCell(
        withIdentifier: MessageBubbleCellType.leftText.rawValue,
        for: indexPath) as! LeftMessageBubbleTableViewCell
    }
    
    cell.messageLabel.text = message.text
    
    return cell
  }
}
