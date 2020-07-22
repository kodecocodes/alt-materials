//: [Previous Page](@previous)
/*:
 # Sampling Pad
 ## A pad with music buttons.
 */

import UIKit
import AVFoundation
import PlaygroundSupport

final class SamplingPad: UIView {
  private var audioPlayer: AVAudioPlayer?
  
  init() {
    let size = CGSize(width: 600, height: 400)
    let frame = CGRect(origin: .zero, size: size)
    super.init(frame: frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  // MARK: - Audio Player
  func set(_ audioPlayer: AVAudioPlayer) {
    audioPlayer.enableRate = true
    self.audioPlayer = audioPlayer
  }
  
  func playAudioPlayer() {
    audioPlayer?.play()
  }
  
  func update(_ volume: Float) {
    audioPlayer?.volume = volume
  }
}


//: ### Embed sampling pad and music buttons in a horizontal stack view.
let samplingPad = SamplingPad()
PlaygroundPage.current.liveView = samplingPad

let rockMusicButton = MusicButton(type: .system)
rockMusicButton.musicGenre = .rock

let jazzMusicButton = MusicButton(type: .system)
jazzMusicButton.musicGenre = .jazz

let popMusicButton = MusicButton(type: .system)
popMusicButton.musicGenre = .pop

let horizontalStackView = HorizontalStackView(arrangedSubviews:
  [rockMusicButton,
   jazzMusicButton,
   popMusicButton])
horizontalStackView.distribution = .fillEqually

//: ### Embed the horizontal stack view into a vertical stack view.
let verticalStackView = VerticalStackView(
  arrangedSubviews: [horizontalStackView])
verticalStackView.translatesAutoresizingMaskIntoConstraints = false
verticalStackView.axis = .vertical
samplingPad.addSubview(verticalStackView)

//: ### Set up vertical stack view layout.
let verticalSpacing: CGFloat = 16
let horizontalSpacing: CGFloat = 16
NSLayoutConstraint.activate(
  [verticalStackView.leadingAnchor.constraint(
    equalTo: samplingPad.leadingAnchor, constant: horizontalSpacing),
   verticalStackView.topAnchor.constraint(
    equalTo: samplingPad.topAnchor, constant: verticalSpacing),
   verticalStackView.trailingAnchor.constraint(
    equalTo: samplingPad.trailingAnchor, constant: -horizontalSpacing),
   verticalStackView.bottomAnchor.constraint(
    equalTo: samplingPad.bottomAnchor, constant: -verticalSpacing)])
samplingPad.layoutIfNeeded()

//: ### Create and set up layouts for volume controls.
let decreaseVolumeButton = VolumeButton(type: .system)
decreaseVolumeButton.volumeButtonType = .decrease

let increaseVolumeButton = VolumeButton(type: .system)
increaseVolumeButton.volumeButtonType = .increase

let volumeSlider = VolumeSlider()

let volumeButtonsStackView = HorizontalStackView(arrangedSubviews:
  [decreaseVolumeButton,
   increaseVolumeButton])
volumeButtonsStackView.distribution = .fillEqually
let volumeControlsStackView = HorizontalStackView(arrangedSubviews:
  [volumeSlider,
   volumeButtonsStackView])
verticalStackView.insertArrangedSubview(
  volumeControlsStackView, at: 0)
volumeButtonsStackView.widthAnchor.constraint(
  equalToConstant: 120).isActive = true
samplingPad.layoutIfNeeded()

//: ### Add spacer view to `volumeControlsStackView`.
let leftSpacerView = UIView()
let rightSpacerView = UIView()
volumeControlsStackView.insertArrangedSubview(leftSpacerView, at: 0)
volumeControlsStackView.addArrangedSubview(rightSpacerView)

//: ### Add width constraints to spacer views.
NSLayoutConstraint.activate(
  [leftSpacerView.widthAnchor.constraint(equalToConstant: 8),
   rightSpacerView.widthAnchor.constraint(equalTo: leftSpacerView.widthAnchor)])
samplingPad.layoutIfNeeded()

//: ### Set up `samplingPad` with  `MusicButtonDelegate`.

extension SamplingPad: MusicButtonDelegate {
  func touchesEnded(_ sender: MusicButton) {
    guard let audioPlayer = sender.makeAudioPlayer() else { return }
    set(audioPlayer)
    playAudioPlayer()
    volumeSlider.setValue(1, animated: true)
  }
}

//: ### Set up `SamplingPad` with  `MusicButtonDelegate` adoption.
[rockMusicButton, jazzMusicButton, popMusicButton]
  .forEach { $0.delegate = samplingPad }

// ### Update volume slider to associate with volume button action.

extension SamplingPad {
  @objc func volumeSliderValueDidChange(_ sender: VolumeSlider) {
    audioPlayer?.volume = sender.value
  }
}
volumeSlider.addTarget(
  samplingPad,
  action: #selector(SamplingPad.volumeSliderValueDidChange),
  for: .valueChanged)

// ### Set up `SamplingPad` with volume buttons.
extension SamplingPad {
  @objc func volumeButtonDidTouchUpInside(_ sender: VolumeButton) {
    let change: Float = sender.volumeButtonType == .increase ? 0.2 : -0.2
    volumeSlider.value += change
    audioPlayer?.volume = volumeSlider.value
  }
}

[increaseVolumeButton, decreaseVolumeButton].forEach {
  $0.addTarget(
    samplingPad,
    action: #selector(SamplingPad.volumeButtonDidTouchUpInside(_:)),
    for: .touchUpInside) }

