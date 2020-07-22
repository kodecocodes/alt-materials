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

class ContactListTableViewController: UITableViewController {
  private var contacts: [Contact] = []
  private let cellIdentififer = "ContactCell"
  @IBOutlet var contactPreviewView: ContactPreviewView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadData()
    configureGestures()
  }
  
  private func loadData() {
    contacts.append(Contact(name: "Cruz Jacqueline Espinal Nieves", photo: "rw-logo", lastMessage:
      """
      Hey, need to talk to you about this awesome project.
      Before you go to New Yorik, we have to meet.
      You won't regret it. Also, I have some some books that Hillary sent to you.
      """, lastTime: Date(timeIntervalSinceNow: -2)))
    contacts.append(Contact(
      name: "Hillary Oliver", photo: "rw-logo",
      lastMessage: "Remember to buy the milk",
      lastTime: Date(timeIntervalSinceNow: -3.2)))
    contacts.append(Contact(
      name: "Noah Librado", photo: "rw-logo",
      lastMessage: "Ok",
      lastTime: Date(timeIntervalSinceNow: -3.9)))
    contacts.append(Contact(
      name: "Yinet Nella", photo: "rw-logo",
      lastMessage: "Ok",
      lastTime: Date(timeIntervalSinceNow: -6.1)))
    contacts.append(Contact(
      name: "Cruz Alberto", photo: "rw-logo",
      lastMessage: "See you soon",
      lastTime: Date(timeIntervalSinceNow: -10.4)))
    contacts.append(Contact(
      name: "Evan Derek", photo: "rw-logo",
      lastMessage: "I'll call you later",
      lastTime: Date(timeIntervalSinceNow: -10.4)))
    contacts.append(Contact(
      name: "Carlos Henry", photo: "rw-logo",
      lastMessage: "I'll call you later",
      lastTime: Date(timeIntervalSinceNow: -10.4)))
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentififer, for: indexPath) as! ContactTableViewCell
    
    let contact = contacts[indexPath.row]
    cell.nameLabel.text = contact.name
    cell.lastMessageLabel.text = contact.lastMessage
    
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "MM/dd/yy h:mm a"
    
    cell.lastTimeLabel.text = dateformatter.string(from: contact.lastTime)
    
    return cell
  }
  
  // MARK: - Setuo Contact Preview
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let contact = contacts[indexPath.row]
    
    contactPreviewView.nameLabel.text = contact.name
    contactPreviewView.photoImageView.image = UIImage(named: contact.photo)
    
    view.addSubview(contactPreviewView)
    
    contactPreviewView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contactPreviewView.widthAnchor.constraint(equalToConstant: 150),
      contactPreviewView.heightAnchor.constraint(equalToConstant: 150),
      contactPreviewView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      contactPreviewView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    contactPreviewView.alpha = 0
    
    UIView.animate(withDuration: 0.3) {
      self.contactPreviewView.alpha = 1
      self.contactPreviewView.transform = CGAffineTransform.identity
    }
  }
  
  private func configureGestures() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideContactPreview))
    
    self.contactPreviewView.addGestureRecognizer(tapGesture)
    self.view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func hideContactPreview() {
    UIView.animate(withDuration: 0.3, animations: {
      self.contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
      self.contactPreviewView.alpha = 0
    }) { (success) in
      self.contactPreviewView.removeFromSuperview()
    }
  }
}
