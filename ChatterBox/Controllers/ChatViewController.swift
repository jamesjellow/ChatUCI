//
//  ChatViewController.swift
//  ChatterBox
//


/*------ Comment ------*/

import UIKit
import Parse

class ChatViewController: UIViewController {

    
    /*------ Outlets + Variables ------*/
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
  @IBOutlet weak var chatNavigationBar: UINavigationBar!
  
  
  // CREATE ARRAY FOR MESSAGES
    var messages: [PFObject] = []
    
    // CREATE CHAT MESSAGE OBJECT
    let chatMessage = PFObject(className: "Message")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
      
      // sync UserDefaults
      UserDefaults.standard.synchronize()
      
      print("CHAT VIEW:-", UserDefaults.standard.string(forKey:"currentCourse")!)
      
      // set title of navigation bar
      //chatNavigationBar.topItem?.title = UserDefaults.standard.string(forKey:"currentCourse")!
      
      
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        
        // Reload messages every second (interval of 1 second)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        tableView.reloadData()
    }
    
    
    
    /*------  Message Functionality ------*/
    
    // TODO: ADD FUNCTIONALITY TO retrieveChatMessages()
    @objc func retrieveChatMessages() {
        // RETRIEVE MESSAGES
//        let query = PFQuery(className: "UCICodepath20")
      
      // get name of chatroom
      let chatroom = UserDefaults.standard.string(forKey: "currentCourse")!
      
      // remove spaces to make legal className for Parse
      let legalChatroom = chatroom.replacingOccurrences(of: " ", with: "")
      
      let query = PFQuery(className: legalChatroom)
      print(legalChatroom)
      
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackground{(messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            }else{
                print(error!.localizedDescription)
            }
        }
        
        
    }
    
    
    // TODO: SEND MESSAGE TO SERVER AFTER onSend IS CLICKED
    @IBAction func onSend(_ sender: Any) {
        // Send message
        if messageTextField.text!.isEmpty == false {
//            let chatMessage = PFObject(className: "UCICodepath20")
          
          // get name of chatroom
          let chatroom = UserDefaults.standard.string(forKey: "currentCourse")!
          
          // remove spaces to make legal className for Parse
          let legalChatroom = chatroom.replacingOccurrences(of: " ", with: "")
          
          
          let chatMessage = PFObject(className: legalChatroom)
          
          
            chatMessage["text"] = messageTextField.text!
            chatMessage["user"] = PFUser.current()
            
            
            chatMessage.saveInBackground{ (sucess, error) in
                if error != nil {
                    print("Message could not be sent")
                }else{
                    self.messageTextField.text = ""
                }
            }
        }
        
    }
    
    /*------ Dismiss Keyboard and Logout ------*/
    
    // TODO: LOG OUT USER
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    

    

}


/*------ TableView Extension Functions ------*/

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
    // BONUS: IMPLEMENT CELL DIDSET
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.chatCell, for: indexPath) as! ChatCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        
        // set the username
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "?"
        }

        // BONUS: ADD avatarImage TO CELL STORYBOARD AND CONNECT TO ChatCell
//        let baseURL = "https://api.adorable.io/avatars/"
//        let imageSize = 20
//        let avatarURL = URL(string: baseURL+"\(imageSize)/\(identifier).png")
//        cell.avatarImage.af_setImage(withURL: avatarURL!)
//        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.height / 2
//        cell.avatarImage.clipsToBounds = true
    

        return cell
    }
    
    
}
