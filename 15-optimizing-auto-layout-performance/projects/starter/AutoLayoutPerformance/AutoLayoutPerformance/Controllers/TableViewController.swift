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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

final class TableViewController: UITableViewController {
  // MARK: - Properties
  private let reuseIdentifier = "reuseIdentifier"
  private var beverages: [Beverage] = []
  
  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupBeverages()
  }
  
  // MARK: - Table View
  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 500
    tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
  }
  
  private func setupBeverages() {
    let beverages = [
      Beverage(name: "Iced Chocolate", username: "swift", isFrequentUser: true, isHighCalorie: true),
      Beverage(name: "Hot Coffee", username: "android", isFrequentUser: true),
      Beverage(name: "Kale Juice", username: "dog"),
      Beverage(name: "Mango Smoothie", username: "cat", isFrequentUser: true, isHighCalorie: true),
      Beverage(name: "Lemon Soda", username: "octopus", isHighCalorie: true),
      Beverage(name: "Water", username: "astronaut", isFrequentUser: true),
      Beverage(name: "Warm Tea", username: "penguin")]
    self.beverages = beverages + beverages
  }
}

// MARK: - UITableViewDataSource
extension TableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return beverages.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: reuseIdentifier) as? TableViewCell
      else { fatalError("Dequeued unregistered cell.") }
    cell.configureCell(beverage: beverages[indexPath.item])
    return cell
  }
}
