//
//  SearchCourseViewController.swift
//  ChatterBox
//
//  Created by Troy Good on 3/10/20.
//

import UIKit

class SearchCourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

  @IBOutlet weak var searchTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
      
  let courses = ["ICS 51", "ICS 53", "ICS 45C", "STATS 111", "CodePath iOS", "ICS 6D", "Philosophy 1", "CS 161", "STATS 120A", "STATS 120B", "STATS 120C"]
  
  var coursesArray = UserDefaults.standard.array(forKey: "courses") as? [String] ?? []
  
    
    var searchClass = [String]()
    var searching = false
  

    override func viewDidLoad() {
        super.viewDidLoad()

      searchTableView.allowsMultipleSelection = true
      
      searchTableView.delegate = self
      searchTableView.dataSource = self
      
      // set searchBar text color to black
      searchBar.searchTextField.textColor = .black
      
      searchTableView.reloadData()
      
  }
  
  
  @IBAction func addSelectedCourses(_ sender: Any) {
    
    print(coursesArray)
    
    
    // add selected courses to user defaults
    UserDefaults.standard.set(coursesArray, forKey: "courses")
    
    print(coursesArray.count)
    
    if (coursesArray.count > 0) {
      // code
      showAlert(self)
    }
    
    searchTableView.reloadData()
  }
  

  @IBAction func showAlert(_ sender: Any) {
    
    let selectedRows = searchTableView.indexPathsForSelectedRows ?? []
    
    var message = ""
    
    for i in selectedRows {
      message += courses[i.item]
      message += "\n"
    }
    
      let alertController = UIAlertController(title: "Courses Added!", message:
          message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

      self.present(alertController, animated: true, completion: nil)
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searching {
        return searchClass.count
    }
    else{
        return courses.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCourseCell") as! SearchCourseCell
    
    if searching{
       cell.searchCourseTitle.text = searchClass[indexPath.item]
    }
    else{
        cell.searchCourseTitle.text = courses[indexPath.item]
    }
    
    let selectedIndexPaths = tableView.indexPathsForSelectedRows
    let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
    cell.accessoryType = rowIsSelected ? .checkmark : .none
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath)!
      cell.accessoryType = .checkmark
    
          let selectedRows = searchTableView.indexPathsForSelectedRows

    if searching{
        for i in selectedRows! {
          print(i.item)
          if !(coursesArray.contains(searchClass[i.item])) {
            print("Course Added!")
            coursesArray.append(searchClass[i.item])
          }
        }
    }
    else{
        for i in selectedRows! {
          print(i.item)
          if !(coursesArray.contains(courses[i.item])) {
            print("Course Added!")
            coursesArray.append(courses[i.item])
          }
        }
    }
    
    print(coursesArray)
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath)!
      cell.accessoryType = .none
    
    if searching{
        coursesArray = coursesArray.filter { $0 != searchClass[indexPath.item]}
    }
    else{
        coursesArray = coursesArray.filter { $0 != courses[indexPath.item]}
    }
    print("Course Removed!")
    print(coursesArray)
  }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        print(searchText)
    //        print("hello")
      searchClass = courses.filter({($0.prefix(searchText.count)).lowercased() == searchText.lowercased()})
        searching = true
        searchTableView.reloadData()
//        print(searchClass)
        }

}

