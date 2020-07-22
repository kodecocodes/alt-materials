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

protocol StoryProgressViewDelegate: class {
  func didSelectProgressItem(at indexPath: IndexPath)
}

final class StoryProgressView: UIView {
  // MARK: - Properties
  private let collectionViewHorizontalInset: CGFloat = 2
  private let collectionViewVerticalInset: CGFloat = 2
  private let lineSpacing: CGFloat = 2
  
  private let selectedBackgroundColor = UIColor.white
  private let deselectedBackgroundColor = UIColor(white: 1, alpha: 0.5)
  
  var selectedIndex: Int = 0 {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.collectionView.reloadData()
      }
    }
  }
  
  private lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(
      top: collectionViewVerticalInset,
      left: collectionViewHorizontalInset,
      bottom: collectionViewVerticalInset,
      right: collectionViewHorizontalInset)
    flowLayout.minimumLineSpacing = lineSpacing
    return flowLayout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  
  private let cellIdentifier = "cellIdentifier"
  private let itemsCount: Int
  
  weak var delegate: StoryProgressViewDelegate?
  
  // MARK: - Initializerss
  init(itemsCount: Int) {
    self.itemsCount = itemsCount
    super.init(frame: .zero)
    backgroundColor = UIColor.black.withAlphaComponent(0.7)
    alpha = 0
    setupCollectionView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.itemsCount = 0
    super.init(coder: aDecoder)
  }
  
  // MARK: - Layout
  private func setupCollectionView() {
    addSubview(collectionView)
    collectionView.fillSuperview()
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    flowLayout.invalidateLayout()
  }
  
  // MARK: - UI
  func fadeAnimation(isFadeIn: Bool) {
    let alpha: CGFloat = isFadeIn ? 0.8 : 0
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
      self.alpha = alpha
    }, completion: nil)
  }
  
}

// MARK: - UICollectionViewDelegate
extension StoryProgressView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndex = indexPath.item
    delegate?.didSelectProgressItem(at: indexPath)
  }
}

// MARK: - UICollectionViewDataSource
extension StoryProgressView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemsCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
    cell.backgroundColor = indexPath.item == selectedIndex
      ? selectedBackgroundColor
      : deselectedBackgroundColor
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension StoryProgressView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let mitigatedInsetsWidth = collectionView.frame.width - collectionViewHorizontalInset * 2
    let mitigatedLineSpacingWidth = mitigatedInsetsWidth - CGFloat(itemsCount - 1) * lineSpacing
    let width = mitigatedLineSpacingWidth / CGFloat(itemsCount)
    let height = collectionView.frame.height - collectionViewVerticalInset * 2
    return CGSize(width: width, height: height)
  }
}
