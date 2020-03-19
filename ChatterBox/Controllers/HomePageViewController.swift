//
//  HomePageViewController.swift
//  ChatterBox
//
//  Created by Troy Good on 3/10/20.
//

import UIKit
import Parse
class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var homeTableView: UITableView!
    //  let myRefreshControl = UIRefreshControl()
  
  // load saved user courses
  var homeCourses = UserDefaults.standard.array(forKey: "courses") as? [String] ?? []

  
  override func viewDidLoad() {
    super.viewDidLoad()

    
    homeTableView.delegate = self
    homeTableView.dataSource = self
    
//    homeTableView.reloadData()

}
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeCourses = UserDefaults.standard.array(forKey: "courses") as? [String] ?? []

//        print("hello")
        homeTableView.reloadData()
        print(homeCourses)
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homeCourses.count
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCourseCell") as! HomeCourseCell
    
    // update the title label for each course
    cell.homeCourseTitle.text = homeCourses[indexPath.item]
    
    return cell
  }
  
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // get cell
    let cell = tableView.cellForRow(at: indexPath) as! HomeCourseCell
    
    // save current course so we know which chatroom to enter
    UserDefaults.standard.set(cell.homeCourseTitle.text, forKey: "currentCourse")
    
    // sync UserDefaults
    UserDefaults.standard.synchronize()
    
    // switch to chatRoom screen
    performSegue(withIdentifier: "chatRoomSegue", sender: self)
    
    // deselect row
    tableView.deselectRow(at: indexPath, animated: false)
    
    
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //let cell = tableView.cellForRow(at: indexPath) as! HomeCourseCell
    
    // nothing is needed here
    // user will enter chatroom immediately after pressing tableCell
  }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        print("Logged Out!")
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginViewController
//        performSegue(withIdentifier: "Authenticated", sender: self)
        
    }
    
  
}
