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

final class PitchControl: UIControl {
  // MARK: - IBOutlets
  @IBOutlet var thumbImageView: UIImageView!
  @IBOutlet var sliderBackgroundImageView: UIImageView!
  @IBOutlet var thumbImageViewTopConstraint: NSLayoutConstraint!
  
  // MARK: - Private UI Properties
  private lazy var view = instantiateNib(view: self)
  
  // MARK: - Private Data Properties
  private let minValue: CGFloat = 0
  private let maxValue: CGFloat = 10
  private let valueIncrement: CGFloat = 1
  private var value: CGFloat = 1 {
  didSet {
      print("Value:", value)
    }
  }
  private var previousTouchLocation = CGPoint()
  
  // MARK: - Private Computed Properties
  private var valueRange: CGFloat {
    return maxValue - minValue + 1
  }
  
  private var halfThumbImageViewHeight: CGFloat {
    return thumbImageView.bounds.height / 2
  }
  
  private var distancePerUnit: CGFloat {
    return (sliderBackgroundImageView.bounds.height / valueRange)
      - (halfThumbImageViewHeight / 2)
  }
  
  // MARK: - Internal Properties
  override var accessibilityValue: String? {
    get {
      return "\(Int(value))"
    }
    set {
      super.accessibilityValue = newValue
    }
  }
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    addSubview(view)
    view.isUserInteractionEnabled = false
    view.fillSuperview(self)
    setupAccessibilityElements()
  }
  
  // MARK: - Touch Tracking Handlers
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.beginTracking(touch, with: event)
    previousTouchLocation = touch.location(in: self)
    let isTouchingThumbImageView = thumbImageView.frame
      .contains(previousTouchLocation)
    thumbImageView.isHighlighted = true
    thumbImageView.isHighlighted = isTouchingThumbImageView
    return isTouchingThumbImageView
  }
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.continueTracking(touch, with: event)
    let touchLocation = touch.location(in: self)
    let deltaLocation = touchLocation.y
      - previousTouchLocation.y
    let deltaValue = (maxValue - minValue)
      * deltaLocation / bounds.height
    previousTouchLocation = touchLocation
    value = boundValue(
      value + deltaValue,
      toLowerValue: minValue,
      andUpperValue: maxValue)
    let isTouchingBackgroundImage =
      sliderBackgroundImageView.frame
        .contains(previousTouchLocation)
    if isTouchingBackgroundImage {
      thumbImageViewTopConstraint.constant =
        touchLocation.y - self.halfThumbImageViewHeight
    }
    return true
  }
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
    thumbImageView.isHighlighted = false
  }
  
  // MARK: - Accessibility Features
  private func setupAccessibilityElements() {
    isAccessibilityElement = true
    accessibilityLabel = "Pitch"
    accessibilityTraits = [.adjustable]
    accessibilityHint = "Adjust pitch"
  }
  
  override func accessibilityIncrement() {
    super.accessibilityIncrement()
    slideThumbInDirection(.down)
  }
  
  override func accessibilityDecrement() {
    super.accessibilityDecrement()
    slideThumbInDirection(.up)
  }
  
  private func slideThumbInDirection(_ direction: Direction) {
    let valueChange: CGFloat
    switch direction {
    case .up:
      valueChange = valueIncrement
    case .down:
      valueChange = valueIncrement * -1
    }
    let newValue = value + valueChange
    if newValue < minValue {
      value = minValue
    } else if newValue > maxValue {
      value = maxValue
    } else {
      value = newValue
    }
    thumbImageViewTopConstraint.constant =
      value * distancePerUnit
  }
  
  // MARK: - Helpers
  private func boundValue(
    _ value: CGFloat,
    toLowerValue lowerValue: CGFloat,
    andUpperValue upperValue: CGFloat) -> CGFloat {
    return min(max(value, lowerValue), upperValue)
  }
}

fileprivate enum Direction {
  case up
  case down
}
