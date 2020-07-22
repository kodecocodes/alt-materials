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

final class InfoViewController: UIViewController {
  @IBOutlet var largeTitleLabel: UILabel!
  @IBOutlet var title1Label: UILabel!
  @IBOutlet var title2Label: UILabel!
  @IBOutlet var title3Label: UILabel!
  @IBOutlet var headlineLabel: UILabel!
  @IBOutlet var bodyLabel: UILabel!
  @IBOutlet var calloutLabel: UILabel!
  @IBOutlet var subheadLabel: UILabel!
  @IBOutlet var footnoteLabel: UILabel!
  @IBOutlet var caption1Label: UILabel!
  @IBOutlet var caption2Label: UILabel!
  
  private var labelTextStyleTuples:
    [(label: UILabel, textStyle: UIFont.TextStyle)] {
    [(largeTitleLabel, .largeTitle),
     (title1Label, .title1),
     (title2Label, .title2),
     (title3Label, .title3),
     (headlineLabel, .headline),
     (bodyLabel, .body),
     (calloutLabel, .callout),
     (subheadLabel, .subheadline),
     (footnoteLabel, .footnote),
     (caption1Label, .caption1),
     (caption2Label, .caption2)
    ]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func cancelBarButtonDidTouchUpInside(_ sender: UIBarButtonItem) {
    DispatchQueue.main.async { [weak self] in
      self?.dismiss(animated: true)
    }
  }
}
