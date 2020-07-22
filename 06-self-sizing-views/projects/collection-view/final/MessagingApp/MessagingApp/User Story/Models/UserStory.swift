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

import Foundation

struct UserStory {
  // MARK: - Value Types
  enum Username: String {
    case swift, android, dog
    var events: [StoryEvent] {
      let events: [StoryEvent]
      switch self {
      case .swift:
        events = [
          StoryEvent(
            title: "Experimenting with the latest technologies...",
            image: #imageLiteral(resourceName: "swift_experimenting")),
          StoryEvent(
            title: "Exploring the sky...",
            image: #imageLiteral(resourceName: "swift_flying")),
          StoryEvent(
            title: "Teaching data structures and algorithms...",
            image: #imageLiteral(resourceName: "swift_teaching"))]
      case .android:
        events = [
          StoryEvent(
            title: "Constructing learning facilities...",
            image: #imageLiteral(resourceName: "android_construction")),
          StoryEvent(
            title: "Hanging out with Swift...",
            image: #imageLiteral(resourceName: "android_hanging_out_with_swift")),
          StoryEvent(
            title: "Lecturing a class on adaptive layouts...",
            image: #imageLiteral(resourceName: "android_teaching_diagram"))
        ]
      case .dog:
        events = [
          StoryEvent(
            title: "Being a bouncer...",
            image: #imageLiteral(resourceName: "dog_bouncer")),
          StoryEvent(
            title: "Basketball training...",
            image: #imageLiteral(resourceName: "dog_basketball")),
          StoryEvent(
            title: "Meditating...",
            image: #imageLiteral(resourceName: "dog_yoga"))
        ]
      }
      return events
    }
  }
  // MARK: - Properties
  let username: Username
  let events: [StoryEvent]
  
  // MARK: - Initializers
  init(username: Username) {
    self.username = username
    events = username.events
  }
}
