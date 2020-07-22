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
import AVFoundation

final class MusicSamplingController: UIViewController {
  // MARK: - Properties
  @IBOutlet var samplingView: SamplingView!
  
  private let musicPlayerViewController: MusicPlayerViewController = {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let viewController = storyboard
      .instantiateViewController(
        withIdentifier: "MusicPlayerViewController")
      as? MusicPlayerViewController
      else { fatalError("Could not instantiate MusicPlayerViewController.") }
    return viewController
  }()
  
  private let notificationCenter = NotificationCenter.default
  private var externalWindows: [UIWindow] = []
  private var mainAudioPlayer: AVAudioPlayer?
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    observeConnectedScreen()
    observeDisconnectedScreen()
    observeScreenResolutionChanges()
    samplingView.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    configureExistingScreen()
  }
  
  // MARK: - External Windows
  private func configureExistingScreen() {
    let screens = UIScreen.screens
    guard
      screens.count > 1,
      let screen = screens.last
      else {
        return
    }
    let window = makeWindow(from: screen)
    externalWindows.append(window)
  }
  
  private func observeConnectedScreen() {
    notificationCenter.addObserver(
      forName: UIScreen.didConnectNotification,
      object: nil,
      queue: nil) { [weak self] notification in
        guard
          let self = self,
          let screen = notification.object as? UIScreen
          else {
            return
        }
        let window = self.makeWindow(from: screen)
        self.externalWindows.append(window)
        self.setMusicGenreLabelVisibility(screen: screen)
    }
  }
  
  private func observeDisconnectedScreen() {
    notificationCenter.addObserver(
      forName: UIScreen.didDisconnectNotification,
      object: nil,
      queue: nil) { [weak self] notification in
        guard
          let self = self,
          let screen = notification.object as? UIScreen
          else {
            return
        }
        for (index, window) in self.externalWindows.enumerated() {
          guard window.screen == screen else { continue }
          self.externalWindows.remove(at: index)
        }
    }
  }
  
  private func observeScreenResolutionChanges() {
    notificationCenter.addObserver(
      forName: UIScreen.modeDidChangeNotification,
      object: nil,
      queue: nil) {[weak self] notification in
        guard
          let self = self,
          let screen = notification.object as? UIScreen
          else {
            return
        }
        self.setMusicGenreLabelVisibility(screen: screen)
    }
  }
  
  private func setMusicGenreLabelVisibility(screen: UIScreen) {
    guard let currentMode = screen.currentMode else { return }
    screen.availableModes.forEach {
      print("Available mode:", $0)
    }
    let lowerBoundSize = CGSize(width: 1024, height: 768)
    self.musicPlayerViewController.musicGenreLabel.isHidden =
      currentMode.size.width <= lowerBoundSize.width
  }
  
  // MARK: - Helper Methods
  private func makeWindow(from screen: UIScreen) -> UIWindow {
    let bounds = screen.bounds
    let window = UIWindow(frame: bounds)
    window.screen = screen
    window.rootViewController = musicPlayerViewController
    window.isHidden = false
    return window
  }
}

// MARK: - SamplingViewDelegate
extension MusicSamplingController: SamplingViewDelegate {
  func musicButtonDidTouchUpInside(withGenreType genre: MusicGenre) {
    guard musicPlayerViewController.selectedMusicGenre != genre else {
      musicPlayerViewController.selectedMusicGenre = .none
      stopAudioPlayer()
      return
    }
    playAudio(withMusicGenre: genre)
    musicPlayerViewController.selectedMusicGenre = genre
  }
  
  private func playAudio(withMusicGenre genre: MusicGenre) {
    guard let url = Bundle.main.url(
      forResource: genre.rawValue,
      withExtension: "m4a") else { return }
    do {
      let audioPlayer = try AVAudioPlayer(contentsOf: url)
      audioPlayer.prepareToPlay()
      audioPlayer.play()
      audioPlayer.numberOfLoops = -1
      mainAudioPlayer = audioPlayer
    } catch {
      print("Audio Player Error:", error)
    }
  }
  
  private func stopAudioPlayer() {
    mainAudioPlayer?.stop()
  }
}
