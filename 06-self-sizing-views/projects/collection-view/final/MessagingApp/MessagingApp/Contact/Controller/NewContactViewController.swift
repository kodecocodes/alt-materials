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

final class NewContactViewController: UIViewController {
  // MARK: - Properties
  private let profileImageView = ProfileImageView(borderShape: .squircle, boldBorder: false)
  
  private let firstNameTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.placeholder = "First name"
    return textField
  }()
  
  private let lastNameTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.placeholder = "Last name"
    return textField
  }()
  
  private var constraints: [NSLayoutConstraint] = []
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "New Contact"
    setupLeftBarButton()
    setupRightBarButton()
    setupViewTapGesture()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    dismissKeyboard(view)
  }
  
  // MARK: - Layouts
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    if !constraints.isEmpty {
      NSLayoutConstraint.deactivate(constraints)
      constraints.removeAll()
    }
    setupViewLayout()
  }
  
  private func setupLeftBarButton() {
    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarButtonItemDidTap(_:)))
    navigationItem.leftBarButtonItem = barButtonItem
  }
  
  private func setupRightBarButton() {
    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonItemDidTap(_:)))
    navigationItem.rightBarButtonItem = barButtonItem
  }
  
  private func setupViewTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
    view.addGestureRecognizer(tapGesture)
  }
  
  private func setupViewLayout() {
    // 1
    let safeAreaInsets = view.safeAreaInsets
    
    let marginSpacing: CGFloat = 16
    let topSpace = safeAreaInsets.top + marginSpacing
    let leadingSpace = safeAreaInsets.left + marginSpacing
    let trailingSpace = safeAreaInsets.right + marginSpacing
    
    // 2
    var constraints: [NSLayoutConstraint] = []
    
    // 3
    view.addSubview(profileImageView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(firstNameTextField)
    firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(lastNameTextField)
    lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
    
    // 1
    let profileImageViewVerticalConstraints =
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-topSpacing-[profileImageView(profileImageViewHeight)]",
        options: [],
        metrics: [
          "topSpacing": topSpace, "profileImageViewHeight": 40],
        views: ["profileImageView": profileImageView])
    constraints += profileImageViewVerticalConstraints
    
    // 2
    let textFieldsVerticalConstraints =
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-topSpacing-[firstNameTextField(profileImageView)]-textFieldsSpacing-[lastNameTextField(firstNameTextField)]",
        options: [.alignAllCenterX],
        metrics: [
          "topSpacing": topSpace,
          "textFieldsSpacing": 8],
        views: [
          "firstNameTextField" : firstNameTextField,
          "lastNameTextField" : lastNameTextField,
          "profileImageView": profileImageView])
    constraints += textFieldsVerticalConstraints
    
    // 3
    let profileImageViewToFirstNameTextFieldHorizontalConstraints =
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-leadingSpace-[profileImageView(profileImageViewWidth)]-[firstNameTextField(>=200@1000)]-trailingSpace-|",
        options: [],
        metrics: [
          "leadingSpace": leadingSpace,
          "trailingSpace": trailingSpace,
          "profileImageViewWidth": 40],
        views: [
          "profileImageView": profileImageView,
          "firstNameTextField": firstNameTextField])
    constraints += profileImageViewToFirstNameTextFieldHorizontalConstraints
    
    // 4
    let lastNameTextFieldHorizontalConstraints =
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:[lastNameTextField(firstNameTextField)]",
        options: [],
        metrics: nil,
        views: [
          "firstNameTextField": firstNameTextField,
          "lastNameTextField" : lastNameTextField])
    constraints += lastNameTextFieldHorizontalConstraints
    
    // 5
    NSLayoutConstraint.activate(constraints)
    self.constraints = constraints
  }
  
  // MARK: - Action
  @objc private func leftBarButtonItemDidTap(_ sender: UIBarButtonItem) {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true)
    }
  }
  
  @objc private func rightBarButtonItemDidTap(_ sender: UIBarButtonItem) {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true)
    }
  }
  
  @objc private func dismissKeyboard(_ sender: UIView) {
    DispatchQueue.main.async { [weak self] in
      self?.view.endEditing(true)
    }
  }
}
