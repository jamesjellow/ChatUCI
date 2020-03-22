//
//  SearchCourseViewController.swift
//  ChatterBox
//
//  Created by Troy Good on 3/10/20.
//

import UIKit
import Alamofire
import SwiftSoup


class SearchCourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  

  @IBOutlet weak var searchTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  @IBOutlet weak var deptTextField: UITextField!
    
  let deptPicker = UIPickerView()
    
      
//  let courses = ["ICS 51", "ICS 53", "ICS 45C", "STATS 111", "CodePath iOS", "ICS 6D", "Philosophy 1", "CS 161", "STATS 120A", "STATS 120B", "STATS 120C"]
  
  var coursesArray = UserDefaults.standard.array(forKey: "courses") as? [String] ?? []

  var courses = [String]()
  
  var departments = [String]()
    
    var searchClass = [String]()
    var searching = false
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      searchTableView.allowsMultipleSelection = true
      
      searchTableView.delegate = self
      searchTableView.dataSource = self
      
      deptTextField.inputView = deptPicker
      deptPicker.delegate = self
      
      // set searchBar text color to black
      searchBar.searchTextField.textColor = .black

      fetchDepartments(deptPicker)

      fetchCourses(searchTableView, department: "AC ENG")
            
      searchTableView.reloadData()

      
  }
  
  func fetchDepartments (_ deptPicker: UIPickerView) {
        
    let urlString = "https://www.reg.uci.edu/perl/WebSoc"
    
    let headers2 = [
      "Connection": "keep-alive",
      "Cache-Control": "max-age=0",
      "DNT": "1",
      "Upgrade-Insecure-Requests": "1",
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36",
      "Sec-Fetch-Dest": "document",
      "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
      "Sec-Fetch-Site": "same-origin",
      "Sec-Fetch-Mode": "navigate",
      "Sec-Fetch-User": "?1",
      "Referer": "https://www.reg.uci.edu/registrar/soc/webreg.html",
      "Accept-Language": "en-US,en;q=0.9",
    ]
    
    
    Alamofire.request(urlString, method: .post, headers: headers2).responseString { (response) in
        if let data2 = response.data, let utf8Text = String(data: data2, encoding: .utf8) {
            do {
                let html2: String = utf8Text
                let doc2: Document = try SwiftSoup.parse(html2)
              
                for lineRow in try! doc2.select("[name=Dept] option[value]") {
                  var deptString = try lineRow.text()
                  
                  let components = deptString.components(separatedBy: ".")
                  
                  deptString = components[0]

                  let components2 = deptString.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
                  let dept = components2.filter { !$0.isEmpty }.joined(separator: " ")
                  
                  if !(dept == "Include All Departments") {
                    self.departments.append(dept)
                  }
                  
                  
              }
              
            } catch let error {
                print(error.localizedDescription)
            }
        }
      self.deptPicker.reloadAllComponents()
      print(self.departments)
    }
  }
  
  
  
  
  func fetchCourses (_ tableView: UITableView, department: String) {
    
    courses = [String]()
    
    let urlString = "https://www.reg.uci.edu/perl/WebSoc"

        let headers = [
          "Connection": "keep-alive",
          "Cache-Control": "max-age=0",
          "Origin": "https://www.reg.uci.edu",
          "Upgrade-Insecure-Requests": "1",
          "DNT": "1",
          "Content-Type": "application/x-www-form-urlencoded",
          "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36",
          "Sec-Fetch-Dest": "document",
          "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
          "Sec-Fetch-Site": "same-origin",
          "Sec-Fetch-Mode": "navigate",
          "Sec-Fetch-User": "?1",
          "Referer": "https://www.reg.uci.edu/perl/WebSoc",
          "Accept-Language": "en-US,en;q=0.9"]

        let data = [  "Submit": "Display Web Results",
                                     "YearTerm": "2020-14",
                                     "ShowComments": "on",
                                     "ShowFinals": "on",
                                     "Breadth": "ANY",
                                     "Dept": "\(department)",
          "CourseNum": "",
          "Division": "ANY",
          "CourseCodes": "",
          "InstrName": "",
        "CourseTitle": "",
        "ClassType": "ALL",
        "Units": "",
        "Days": "",
        "StartTime": "",
        "EndTime": "",
        "MaxCap": "",
        "FullCourses": "ANY",
        "FontSize": "100",
        "CancelledCourses": "Exclude",
        "Bldg": "",
        "Room": ""]
        
    
    
    Alamofire.request(urlString, method: .post, parameters: data,encoding: URLEncoding.default, headers: headers).responseString { (response) in
                      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                          do {
                              let html: String = utf8Text
                              let doc: Document = try SwiftSoup.parse(html)
                            
                              for lineRow in try! doc.select("td.CourseTitle") {
                                var courseString = try lineRow.text()
                                let regex = "(Prerequisites)"
                                let repl = ""
                                
                                courseString = courseString.replacingOccurrences(of: regex, with: repl)
                                
                                let components = courseString.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
                                
                                let course = components.filter { !$0.isEmpty }.joined(separator: " ")
                                
                                self.courses.append(course)
                                // this is the title of the course as a string
                                print(course)
                                
                              }
                            
                          } catch let error {
                              print(error.localizedDescription)
                          }

                      }
      
                    self.searchTableView.reloadData()

                  }
    
  }
  
  
  @IBAction func addSelectedCourses(_ sender: Any) {
    
//    print(coursesArray)
    
    
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
          if !(coursesArray.contains(searchClass[i.item])) {
            print("Course Added!")
            coursesArray.append(searchClass[i.item])
          }
        }
    }
    else{
        for i in selectedRows! {
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
//    print(coursesArray)
  }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      searchClass = courses.filter({($0.prefix(searchText.count)).lowercased() == searchText.lowercased()})
        searching = true
        searchTableView.reloadData()
        }
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return departments.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return departments[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print(departments[row])
    deptTextField.text = departments[row]
  }
  
  
  @IBAction func searchButton(_ sender: Any) {
    fetchCourses(searchTableView, department: deptTextField.text ?? departments[0])
     searchTableView.reloadData()
     self.view.endEditing(true)
  }
  
}

