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

final class MessagesViewController: UIViewController {
  // MARK: - Properties
  private let userStories = [
    UserStory(username: .swift),
    UserStory(username: .android),
    UserStory(username: .dog)]
  
  private lazy var miniStoryView = MiniStoryView(userStories: userStories)
  
  // MARK: - Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupMiniStoryView()
  }
  
  // MARK: - Layouts
  private func setupMiniStoryView() {
    view.addSubview(miniStoryView)
    miniStoryView.backgroundColor = .lightGray
    miniStoryView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [miniStoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
       miniStoryView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
       miniStoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       miniStoryView.heightAnchor.constraint(equalToConstant: 80)]
    )
    miniStoryView.delegate = self
  }
}

// MARK: - MiniStoryViewDelegate
extension MessagesViewController: MiniStoryViewDelegate {
  func didSelectUserStory(atIndex index: Int) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      let userStory = self.userStories[index]
      let viewController = UserStoryViewController(userStory: userStory)
      let navigationController = UINavigationController(
        rootViewController: viewController)
      navigationController.modalPresentationStyle = .fullScreen
      self.present(navigationController, animated: true)
    }
  }
}
