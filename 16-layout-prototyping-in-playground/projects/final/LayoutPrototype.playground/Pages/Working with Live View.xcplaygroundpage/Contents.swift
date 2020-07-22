//: [Previous Page](@previous)
/*:
 # Working with [live view](https://developer.apple.com/documentation/playgroundsupport/playgroundpage/1964506-liveview)
 ## Featuring rock, jazz and pop samples.
 ### By: Your Name
 */

import UIKit
import PlaygroundSupport

//: `view` is used for experimental purposes on this page.

// 1
let size = CGSize(width: 400, height: 400)
let frame = CGRect(origin: .zero, size: size)
let view = UIView(frame: frame)

// 2
PlaygroundPage.current.liveView = view

view.backgroundColor = .lightGray
view.backgroundColor = .blue
view.backgroundColor = .red
view.backgroundColor = .magenta

view.layer.cornerRadius = 50
view.layer.masksToBounds = true
view.layoutIfNeeded()

let label = UILabel()
label.backgroundColor = .white
view.addSubview(label)

label.translatesAutoresizingMaskIntoConstraints = false

let labelLeadingAnchorConstraint = label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
let labelTraillingAnchorConstraint = label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
let labelTopAnchorConstraint = label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8)

labelLeadingAnchorConstraint.isActive = true
labelTraillingAnchorConstraint.isActive = true
labelTopAnchorConstraint.isActive = true

label.text = "Hello, wonderful people!"
view.layoutIfNeeded()

label.font = UIFont.systemFont(ofSize: 64, weight: .bold)
label.adjustsFontSizeToFitWidth = true

labelLeadingAnchorConstraint.constant = 24
labelTraillingAnchorConstraint.constant = -24
labelTopAnchorConstraint.constant = 24

view.layoutIfNeeded()

label.textAlignment = .center
label.backgroundColor = .clear
label.textColor = .white
label.text = "WONDERFUL PEOPLE!"

label.removeConstraint(labelTopAnchorConstraint)
let labelCenterYAnchorConstraint = label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32)
labelCenterYAnchorConstraint.isActive = true
view.layoutIfNeeded()

UIView.animate(withDuration: 3, delay: 1, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
  labelCenterYAnchorConstraint.constant -= 32
  view.layoutIfNeeded()
}, completion: nil)

//: [Next Page](@next)
