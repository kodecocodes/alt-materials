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
import AVFoundation

//public protocol MusicButtonDelegate: class {
//  func touchesEnded(_ sender: MusicButton)
//}
//
//public final class MusicButton: UIButton {
//  // MARK: Properties
//  public var musicGenre: MusicGenre = .other {
//    didSet {
//      backgroundColor = musicGenre.backgroundColor
//      setTitle(musicGenre.rawValue.uppercased(), for: .normal)
//      titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
//    }
//  }
//
//  public weak var delegate: MusicButtonDelegate?
//
//  // MARK: Initializers
//  override public init(frame: CGRect) {
//    super.init(frame: frame)
//    layer.masksToBounds = true
//    setTitleColor(.white, for: .normal)
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//  }
//
//  // MARK: Layouts
//  override public func layoutSubviews() {
//    super.layoutSubviews()
//    layer.cornerRadius = frame.width / 5
//  }
//
//  // MARK: AVAudioPlayer
//  @objc public func makeAudioPlayer() -> AVAudioPlayer? {
//    guard let url = Bundle.main.url(
//      forResource: musicGenre.rawValue,
//      withExtension: "m4a") else { return nil }
//    do {
//      let audioPlayer = try AVAudioPlayer(contentsOf: url)
//      audioPlayer.numberOfLoops = -1
//      audioPlayer.prepareToPlay()
//      return audioPlayer
//    } catch {
//      print("Audio Player Error:", error)
//      return nil
//    }
//  }
//
//  // MARK: Actions
//  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//    super.touchesEnded(touches, with: event)
//    delegate?.touchesEnded(self)
//  }
//}
