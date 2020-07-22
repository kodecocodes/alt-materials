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

final class UserStoryViewController: UIViewController {
  // MARK: - Properties
  private let userStory: UserStory
  private let cellIdentifier = "cellIdentifier"
  private let headerViewIdentifier = "headerViewIdentifier"
  private var currentItemIndex = 0
  
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    return flowLayout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: flowLayout)
    collectionView.backgroundColor = .systemBackground
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isPagingEnabled = true
    collectionView.bounces = false
    collectionView.register(
      StoryEventCollectionViewCell.self,
      forCellWithReuseIdentifier: cellIdentifier)
    collectionView.register(
      HeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: headerViewIdentifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    return collectionView
  }()
  
  private lazy var swipeDownGesture: UISwipeGestureRecognizer = {
    let swipeGesture = UISwipeGestureRecognizer(
      target: self,
      action: #selector(dismissControllerAction))
    swipeGesture.direction = .down
    return swipeGesture
  }()
  
  // MARK: - Initializers
  init(userStory: UserStory) {
    self.userStory = userStory
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .systemBackground
    title = "@\(userStory.username.rawValue)"
    setupNavigationBar()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addGestureRecognizer(swipeDownGesture)
    setupCollectionView()
  }
  
  // MARK: - Scroll View
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let contentOffsetX = targetContentOffset.pointee.x
    let scrollViewWidth = scrollView.frame.width
    currentItemIndex = Int(contentOffsetX / scrollViewWidth)
  }
  
  // MARK: - Layouts
  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    let safeAreaLayoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate(
      [collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
       collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
       collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
       collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)]
    )
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    centerCollectionViewContent()
  }
  
  // MARK: UI
  private func centerCollectionViewContent() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      let x = self.collectionView.frame.width * CGFloat(self.currentItemIndex)
      let y: CGFloat = 0
      let contenOffset = CGPoint(x: x, y: y)
      self.collectionView.setContentOffset(contenOffset, animated: false)
    }
  }
  
  private func setupNavigationBar() {
    let leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(dismissControllerAction))
    navigationItem.leftBarButtonItem = leftBarButtonItem
  }
  
  // MARK: - Actions
  @objc private func dismissControllerAction() {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true, completion: nil)
    }
  }
}

// MARK: - UICollectionViewDataSource
extension UserStoryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userStory.events.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? StoryEventCollectionViewCell
      else { fatalError("Dequeued unregistered cell") }
    let item = indexPath.item
    let storyEvent = userStory.events[item]
    cell.configureCell(storyEvent: storyEvent)
    cell.backgroundColor = item % 2 == 0 ? .lightGray : .darkGray
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let headerView = collectionView.dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: headerViewIdentifier,
      for: indexPath) as? HeaderCollectionReusableView
      else { fatalError("Dequeued unregistered reusable view") }
    headerView.configureCell(username: userStory.username)
    return headerView
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserStoryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return collectionView.frame.size
  }
}
