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

class TasksTableViewController: UITableViewController {
  var tasks: [Task] = [
    Task(
      name: NSLocalizedString(
        "Buy new table",
        comment: "Buy new table task"),
      isDone: true,
      isFavorited: false),
    Task(
      name: NSLocalizedString(
        "Pickup kids at school",
        comment: "Pickup kids at school task"),
      isDone: false,
      isFavorited: true),
    Task(
      name: NSLocalizedString(
        "Take out the trash",
        comment: "Take out the trash task"),
      isDone: false,
      isFavorited: false),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGestures()
  }
  
  @IBAction func showNotificationButtonTapped(_ sender: Any) {
    showNotification()
  }
  
  private func setupNotificationView() {
    notificationView.addSubview(iconImageView)
    notificationView.addSubview(greetingLabel)
    notificationView.addSubview(contentLabel)
    
    NSLayoutConstraint.activate([
      notificationView.widthAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.widthAnchor,
        multiplier: 0.8),
      notificationView.heightAnchor.constraint(equalToConstant: 200),
      notificationView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: 50),
      notificationView.centerXAnchor.constraint(
        equalTo: view.centerXAnchor)
      ]
    )
    
    NSLayoutConstraint.activate([
      iconImageView.widthAnchor.constraint(equalToConstant: 50),
      iconImageView.heightAnchor.constraint(equalToConstant: 50),
      iconImageView.topAnchor.constraint(
        equalTo: notificationView.topAnchor,
        constant: 20),
      iconImageView.centerXAnchor.constraint(
        equalTo: view.centerXAnchor)
      ]
    )
    
    NSLayoutConstraint.activate([
      greetingLabel.leftAnchor.constraint(
        equalTo: notificationView.leftAnchor,
        constant: 20),
      greetingLabel.topAnchor.constraint(
        equalTo: iconImageView.bottomAnchor,
        constant: 20),
      ]
    )
    
    NSLayoutConstraint.activate([
      contentLabel.topAnchor.constraint(
        equalTo: greetingLabel.bottomAnchor,
        constant: 20),
      contentLabel.widthAnchor.constraint(
        equalTo: notificationView.widthAnchor,
        multiplier: 0.8),
      contentLabel.centerXAnchor.constraint(
        equalTo: view.centerXAnchor)
      ]
    )
  }
  
  private func configureGestures() {
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(hideContactPreview))
    
    notificationView.addGestureRecognizer(tapGesture)
    view.addGestureRecognizer(tapGesture)
  }
  
  private func showNotification() {
    view.addSubview(notificationView)
    setupNotificationView()
    notificationView.transform = CGAffineTransform(
      scaleX: 1.25,
      y: 1.25)
    notificationView.alpha = 0
    
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.notificationView.alpha = 1
      self.notificationView.transform = .identity
    }
  }
  
  @objc private func hideContactPreview() {
    UIView.animate(withDuration: 0.3, animations: { [weak self] in
      guard let self = self else { return }
      self.notificationView.transform = CGAffineTransform(
        scaleX: 1.25,
        y: 1.25)
      self.notificationView.alpha = 0
    }) { (success) in
      self.notificationView.removeFromSuperview()
    }
  }
  
  lazy var notificationView: UIView = {
    let notificationView = UIView()
    notificationView.translatesAutoresizingMaskIntoConstraints = false
    notificationView.backgroundColor = .white
    notificationView.layer.borderColor = UIColor.clear.cgColor
    notificationView.layer.borderWidth = 1.0
    notificationView.layer.cornerRadius = 20.0
    notificationView.layer.shadowColor = UIColor.lightGray.cgColor
    notificationView.layer.shadowOpacity = 0.7
    notificationView.layer.shadowOffset = CGSize(
      width: 1,
      height: 1)
    
    return notificationView
  }()
  
  lazy var iconImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(
      named: "notification-icon"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  lazy var greetingLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = NSLocalizedString(
      "Hi, there",
      comment: "Welcome message")
    label.font = UIFont.systemFont(ofSize: 13.0)
    label.textColor = .gray
    
    return label
  }()
  
  lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 15.0)
    label.textColor = .gray
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = NSLocalizedString(
      "You have some tasks waiting for you",
      comment: "Pending noticiations message")
    label.textAlignment = .center
    
    return label
  }()
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "TaskCell",
      for: indexPath) as? TaskTableViewCell else {
        fatalError("Dequeued unregistered reusable view")
    }
    
    let task = tasks[indexPath.row]
    cell.configure(task)
    
    return cell
  }
}
