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

class TimerView: UIView {
  var seconds = 0
  private var timer = Timer()
  private var timerLabel: UILabel!
  private var labelConstraints = [NSLayoutConstraint]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupTimer()
  }
  
  func startTime() {
    timerLabel.text = "00 : 00"
    if timer.isValid {
      stopTimer()
    }
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      self.seconds += 1
      self.timerLabel.text = self.formatSeconds(self.seconds)
    }
  }
  
  func stopTimer() {
    timer.invalidate()
    seconds = 0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupTimer() {
    timerLabel = UILabel()
    timerLabel.text = "00 : 00"
    timerLabel.font = UIFont.boldSystemFont(ofSize: 13)
    timerLabel.textColor = .white
    timerLabel.translatesAutoresizingMaskIntoConstraints = false

    addSubview(timerLabel)
    needsUpdateConstraints()
  }
  
  private func formatSeconds(_ seconds: Int) -> String {
    let minutesPart: Int = seconds/60
    let secondsPart: Int = seconds % 60
    
    return "\(String(format: "%02d", minutesPart)) : \(String(format: "%02d",secondsPart))"
  }
  
  override func updateConstraints() {
    NSLayoutConstraint.deactivate(labelConstraints)
    labelConstraints.removeAll()
    
    labelConstraints.append(timerLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor))
    
    NSLayoutConstraint.activate(labelConstraints)
    super.updateConstraints()
  }
}
