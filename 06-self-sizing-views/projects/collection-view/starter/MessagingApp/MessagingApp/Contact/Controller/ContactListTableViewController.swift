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

final class ContactListTableViewController: UITableViewController {
  private var contacts: [Contact] =
    [Contact(name: "John Doe", photo: "rw-logo"),
     Contact(name: "Jane Doe", photo: "rw-logo"),
     Contact(name: "Joseph Doe", photo: "rw-logo")]
  
  private let cellIdentififer = "ContactCell"
  var contactPreviewView: ContactPreviewView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = 40
    
    contactPreviewView = ContactPreviewView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    
    tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellIdentififer)
    
    configureGestures()
    setupNavigationBar()
  }
  
  // MARK: - Gestures
  private func configureGestures() {
    //1
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideContactPreview))
    //2
    contactPreviewView.addGestureRecognizer(tapGesture)
    view.addGestureRecognizer(tapGesture)
  }
  
  // MARK: - UI
  private func setupNavigationBar() {
    let rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(rightBarButtonItemDidTap))
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  // MARK: - Action
  @objc private func hideContactPreview() {
    //1
    UIView.animate(withDuration: 0.3, animations: {
      self.contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
      self.contactPreviewView.alpha = 0
    }) { (success) in
      //2
      self.contactPreviewView.removeFromSuperview()
    }
  }
  
  @objc private func rightBarButtonItemDidTap(_ sender: UIBarButtonItem) {
    let navigationController = UINavigationController(rootViewController: NewContactViewController())
    DispatchQueue.main.async { [weak self] in
      self?.present(navigationController, animated: true)
    }
  }
}

// MARK: - UITableViewDelegate
extension ContactListTableViewController {
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    //1
    let contact = contacts[indexPath.row]
    
    //2
    contactPreviewView.nameLabel.text = contact.name
    
    //3
    contactPreviewView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(contactPreviewView)
    
    //4
    
    NSLayoutConstraint.activate([
      contactPreviewView.widthAnchor.constraint(equalToConstant: 150),
      contactPreviewView.heightAnchor.constraint(equalToConstant: 150),
      contactPreviewView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      contactPreviewView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    //5
    contactPreviewView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    contactPreviewView.alpha = 0
    
    //6
    UIView.animate(withDuration: 0.3) {
      self.contactPreviewView.alpha = 1
      self.contactPreviewView.transform = CGAffineTransform.identity
    }
  }
}

// MARK: - UITableViewDataSource
extension ContactListTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //1
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentififer, for: indexPath) as! ContactTableViewCell
    
    //2
    let contact = contacts[indexPath.row]
    cell.nameLabel.text = contact.name
    
    return cell
  }
}
