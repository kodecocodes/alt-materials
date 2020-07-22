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

protocol MiniStoryViewDelegate: class {
  func didSelectUserStory(atIndex index: Int)
}

final class MiniStoryView: UIView {
  // MARK: - Properties
  private let cellIdentifier = "cellIdentifier"
  
  private let verticalInset: CGFloat = 8
  private let horizontalInset: CGFloat = 16
  
  private let userStories: [UserStory]
  
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = 16
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(
      top: verticalInset,
      left: horizontalInset,
      bottom: verticalInset,
      right: horizontalInset)
    return flowLayout
  }()
  
  weak var delegate: MiniStoryViewDelegate?
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: flowLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      MiniStoryCollectionViewCell.self,
      forCellWithReuseIdentifier: cellIdentifier)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.alwaysBounceHorizontal = true
    collectionView.backgroundColor = .systemGroupedBackground
    return collectionView
  }()
  
  // MARK: - Initializers
  init(userStories: [UserStory]) {
    self.userStories = userStories
    super.init(frame: .zero)
    setupCollectionView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.userStories = []
    super.init(coder: aDecoder)
  }
  
  // MARK: - Layouts
  override func layoutSubviews() {
    super.layoutSubviews()
    let height = collectionView.frame.height - verticalInset * 2
    let width = height
    let itemSize = CGSize(width: width, height: height)
    flowLayout.itemSize = itemSize
  }
  
  private func setupCollectionView() {
    addSubview(collectionView)
    collectionView.fillSuperview()
  }
  
}

// MARK: - UICollectionViewDataSource
extension MiniStoryView: UICollectionViewDataSource {
  // 1
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userStories.count
  }
  
  // 2
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView .dequeueReusableCell(
      withReuseIdentifier: cellIdentifier,
      for: indexPath) as? MiniStoryCollectionViewCell
      else { fatalError("Dequeued Unregistered Cell") }
    let username = userStories[indexPath.item].username
    cell.configureCell(imageName: username.rawValue)
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension MiniStoryView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelectUserStory(atIndex: indexPath.item)
  }
}
