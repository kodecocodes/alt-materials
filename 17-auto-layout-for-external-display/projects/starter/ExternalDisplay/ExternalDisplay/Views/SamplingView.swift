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

// MARK: - Protocol
protocol SamplingViewDelegate: class {
  func musicButtonDidTouchUpInside(withGenreType genre: MusicGenre)
}

// MARK: - SamplingView
final class SamplingView: UIView {
  // MARK: - Properties
  weak var delegate: SamplingViewDelegate?
  
  private let rockMusicButton: MusicButton = {
    let button = MusicButton(type: .system)
    button.musicGenre = .rock
    button.addTarget(
      self,
      action: #selector(musicButtonDidTouchUpInside(_:)),
      for: .touchUpInside)
    return button
  }()
  
  private let jazzMusicButton: MusicButton = {
    let button = MusicButton(type: .system)
    button.musicGenre = .jazz
    button.addTarget(
      self,
      action: #selector(musicButtonDidTouchUpInside(_:)),
      for: .touchUpInside)
    return button
  }()
  
  private let popMusicButton: MusicButton = {
    let button = MusicButton(type: .system)
    button.musicGenre = .pop
    button.addTarget(
      self,
      action: #selector(musicButtonDidTouchUpInside(_:)),
      for: .touchUpInside)
    return button
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [rockMusicButton, jazzMusicButton, popMusicButton])
    stackView.spacing = 16
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupStackView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupStackView()
  }
  
  // MARK: - Layout
  private func setupStackView() {
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate(
      [stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
       stackView.topAnchor.constraint(equalTo: topAnchor),
       stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
       stackView.bottomAnchor.constraint(equalTo: bottomAnchor)]
    )
  }
  
  // MARK: - Actions
  @objc private func musicButtonDidTouchUpInside(_ sender: MusicButton) {
    guard let genre = sender.musicGenre else { return }
    delegate?.musicButtonDidTouchUpInside(withGenreType: genre)
  }
}
