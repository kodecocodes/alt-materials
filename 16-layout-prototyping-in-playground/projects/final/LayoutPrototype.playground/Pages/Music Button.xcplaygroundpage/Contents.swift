//: [Previous Page](@previous)
/*:
 # Music Button
 ## The magical button that plays music.
 */

import UIKit
import AVFoundation
import PlaygroundSupport

//final class MusicButton: UIButton {
//
//  // MARK: Properties
//  var musicGenre: MusicGenre = .other {
//    didSet {
//      backgroundColor = musicGenre.backgroundColor
//      setTitle(musicGenre.rawValue.uppercased(), for: .normal)
//      titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
//    }
//  }
//
//  // MARK: Initializers
//  override init(frame: CGRect) {
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
//  override func layoutSubviews() {
//    super.layoutSubviews()
//    layer.cornerRadius = frame.width / 5
//  }
//
//  // MARK: AVPlayer
//  func makeAudioPlayer() -> AVAudioPlayer? {
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
//}

let size = CGSize(width: 200, height: 300)
let frame = CGRect(origin: .zero, size: size)
let musicButton = MusicButton(frame: frame)

PlaygroundPage.current.liveView = musicButton

//: Different music genre gives `MusicButton` a different look.
musicButton.musicGenre = .rock
musicButton.musicGenre = .jazz
musicButton.musicGenre = .pop

/*:
 Each music genre is associated with an audio track from the **Resources** folder.

 You can prepare the audio player by calling `makeAudioPlayer()`.

 Afterward, you can call `play()` on the audio player to play the associated audio track`.

 */

let audioPlayer = musicButton.makeAudioPlayer()
audioPlayer?.play()
audioPlayer?.volume -= 0.5
audioPlayer?.volume += 0.5

//: [Next Page](@next)
