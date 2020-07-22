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

final class ProfileViewController: UIViewController {
  // MARK: - Properties
  private let profileHeaderView = ProfileHeaderView()
  private let mainStackView = UIStackView()
  private let scrollView = UIScrollView()
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupScrollView()
    setupMainStackView()
  }
  
  // MARK: - Layouts
  private func setupProfileHeaderView() {
    mainStackView.addArrangedSubview(profileHeaderView)
    profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
    profileHeaderView.heightAnchor.constraint(equalToConstant: 360).isActive = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func setupMainStackView() {
    mainStackView.axis = .vertical
    mainStackView.distribution = .equalSpacing
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    //1
    scrollView.addSubview(mainStackView)
    
    //2
    let contentLayoutGuide = scrollView.contentLayoutGuide
    
    NSLayoutConstraint.activate([
      //3
      mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
      mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
      mainStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
      //4
      mainStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
    ])
    
    setupProfileHeaderView()
    setupButtons()
  }
  
  private func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
    
    let frameLayoutGuide = scrollView.frameLayoutGuide
    
    NSLayoutConstraint.activate([
      frameLayoutGuide.leadingAnchor.constraint(equalTo:
        view.leadingAnchor),
      frameLayoutGuide.trailingAnchor.constraint(equalTo:
        view.trailingAnchor),
     frameLayoutGuide.topAnchor.constraint(equalTo:
        view.safeAreaLayoutGuide.topAnchor),
      frameLayoutGuide.bottomAnchor.constraint(equalTo:
        view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - Buttons Configuration
extension ProfileViewController {
  private func createButton(text: String, color: UIColor = .blue) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 55).isActive = true
    button.setTitle(text, for: .normal)
    button.setTitleColor(color, for: .normal)
    button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
    button.contentHorizontalAlignment = .left
    
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    return button
  }
  
  @objc private func buttonPressed(_ sender: UIButton) {
    let buttonTitle = sender.titleLabel?.text ?? ""
    let message = "\(buttonTitle) button has been pressed"
    
    let alert = UIAlertController(
      title: "Button Pressed",
      message: message,
      preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  func setupButtons() {
    let buttonTitles = [
      "Share Profile", "Favorites Messages", "Saved Messages",
      "Bookmarks", "History", "Notifications", "Find Friends",
      "Security", "Help", "Logout"]
    
    let buttonStack = UIStackView()
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.alignment = .fill
    buttonStack.axis = .vertical
    buttonStack.distribution = .equalSpacing
    
    buttonTitles.forEach { (buttonTitle) in
      buttonStack.addArrangedSubview(createButton(text: buttonTitle))
    }
    
    mainStackView.addArrangedSubview(buttonStack)
    NSLayoutConstraint.activate([
      buttonStack.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
      buttonStack.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
    ])
  }
}
