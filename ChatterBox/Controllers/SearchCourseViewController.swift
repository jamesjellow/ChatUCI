//
//  SearchCourseViewController.swift
//  ChatterBox
//
//  Created by Troy Good on 3/10/20.
//

import UIKit

class SearchCourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var searchTableView: UITableView!

  
  let courses = ["ICS 51", "ICS 45C", "STATS 111", "CodePath iOS", "ICS 6D", "Philosophy 1", "CS 161", "STATS 120A", "STATS 120B", "STATS 120C"]
  
  var coursesArray = UserDefaults.standard.array(forKey: "courses") as? [String] ?? []

    override func viewDidLoad() {
        super.viewDidLoad()

      searchTableView.allowsMultipleSelection = true
      
      searchTableView.delegate = self
      searchTableView.dataSource = self
      
      searchTableView.reloadData()
      
  }
  
  
  @IBAction func addSelectedCourses(_ sender: Any) {
    
    print(coursesArray)
    
    // CURRENTLY COMMENTED OUT TO NOT CLUTTER USER DEFAULTS
    
    // add selected courses to user defaults
    //UserDefaults.standard.set(coursesArray, forKey: "courses")

  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return courses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
    
    cell.searchCourseTitle.text = courses[indexPath.item]
    
    let selectedIndexPaths = tableView.indexPathsForSelectedRows
    let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
    cell.accessoryType = rowIsSelected ? .checkmark : .none
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath)!
      cell.accessoryType = .checkmark
    
          let selectedRows = searchTableView.indexPathsForSelectedRows

    
    for i in selectedRows! {
      print(i.item)
      if !(coursesArray.contains(courses[i.item])) {
        print("Course Added!")
        coursesArray.append(courses[i.item])
      }
    }
    
    print(coursesArray)
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath)!
      cell.accessoryType = .none
        
    coursesArray = coursesArray.filter { $0 != courses[indexPath.item]}
    
    print("Course Removed!")
    print(coursesArray)
  }
  


}
