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

// MARK: - CollectionViewController
final class CollectionViewController: UICollectionViewController {
  // MARK: - Properties
  private let cellIdentifier = "CollectionViewCell"
  private let shapes = Shape.makeShapes(
    shapeNames: [.circle, .square, .star, .oval, .triangle, .hexagon])
  
  // MARK: - Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionViewLayout()
  }
  
  // MARK: - Layouts
  override func traitCollectionDidChange(
    _ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory
      else { return }
    collectionView.collectionViewLayout.invalidateLayout()
  }
  
  // MARK: - Flow Layout
  private func setupCollectionViewLayout() {
    guard let collectionViewLayout =
      collectionView.collectionViewLayout
        as? CollectionViewLayout else { return }
    collectionViewLayout.delegate = self
  }
  
  // MARK: - Actions
  @IBAction func cancelBarButtonDidTouchUpInside(_ sender: UIBarButtonItem) {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true)
    }
  }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return shapes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellIdentifier, for: indexPath)
      as? CollectionViewCell
      else { fatalError("Failed to dequeued CollectionViewCell.") }
    let shape = shapes[indexPath.item]
    cell.configureCell(shape: shape)
    return cell
  }
}

extension CollectionViewController: CollectionViewLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForImageAtIndexPath indexPath: IndexPath)
    -> CGFloat {
      return shapes[indexPath.item].image.size.height
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    labelTextAtIndexPath indexPath: IndexPath)
    -> String {
      return shapes[indexPath.item].shapeName.rawValue
  }
}
