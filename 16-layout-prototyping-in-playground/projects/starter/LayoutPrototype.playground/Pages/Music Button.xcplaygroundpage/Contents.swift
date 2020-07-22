//: [Previous Page](@previous)
/*:
 # Music Button
 ## The magical button that plays music.
 */

import UIKit
import AVFoundation
import PlaygroundSupport

final class MusicButton: UIButton {
  // MARK: - Properties
  var musicGenre: MusicGenre = .other {
    didSet {
      backgroundColor = musicGenre.backgroundColor
      setTitle(musicGenre.rawValue.uppercased(), for: .normal)
      titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
  }

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.masksToBounds = true
    setTitleColor(.white, for: .normal)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Layouts
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.width / 5
  }

  // MARK: - AVPlayer
  func makeAudioPlayer() -> AVAudioPlayer? {
    guard let url = Bundle.main.url(
      forResource: musicGenre.rawValue,
      withExtension: "m4a") else { return nil }
    do {
      let audioPlayer = try AVAudioPlayer(contentsOf: url)
      audioPlayer.numberOfLoops = -1
      audioPlayer.prepareToPlay()
      return audioPlayer
    } catch {
      print("Audio Player Error:", error)
      return nil
    }
  }
}

//: [Next Page](@next)
