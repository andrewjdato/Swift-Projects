//
//  ViewController.swift
//  ChatBot
//
//  Created by Andrew Dato on 5/10/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet var messageView: UITableView!
    @IBOutlet weak var userTextField: UITextField!
    var messages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        messages.append("Please Insert Text in the Text Field")
        self.messageView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //Used to track the color of the message cells
    //0 = user
    //1 = bot
    var cellColor = 3
    var imageInsert = false
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        if imageInsert == false {
            cell.textLabel?.text = messages[indexPath.row]
            if cellColor == 0 {
                cell.backgroundColor = .green
            } else if cellColor == 1{
                cell.backgroundColor = .blue
                cell.textLabel?.textColor = .white
            }
        } else {
            cell.textLabel?.text = messages[indexPath.row]
            cell.imageView?.image = image
            imageInsert = false
            cell.backgroundColor = .green
        }
        return cell
    }
    
    //Update the cells to display more messages
    func updateCells() {
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        
        messageView.beginUpdates()
        messageView.insertRows(at: [indexPath], with: .automatic)
        messageView.endUpdates()
    }
    
    //Function Used to take in the string and determine a response
    //It Will detect several keywords to try to determine a response to
    //give by cycling through all of the words in the string
    //and returning an  appropiate response
    //To insert more responses you can just add more switch and
    //if statements to this
    func botResponse(text: String) {
        let words = text.lowercased().split(separator: " ")
        cellColor = 1
        var count = 0
        var response = false
        for oneWord in words {
            switch oneWord {
            
            //Greeting Key Words
            case "hello":
                messages.append("Bot9000: Hi!")
                updateCells()
                response = true
            
            case "hi":
                messages.append("Bot9000: Hi!")
                updateCells()
                response = true
                
            case "hey":
                messages.append("Bot9000: Hi!")
                updateCells()
                response = true
            
            case "good" :
                //Check for variations of good morning
                //make sure that the next word is
                //one of the following
                if (count + 1) < words.count {
                    if words[count+1] == "morning"{
                        messages.append("Bot9000: Good Morning!")
                        updateCells()
                        response = true
                    } else if words[count+1] == "evening"{
                        messages.append("Bot9000: Good Evening!")
                        updateCells()
                        response = true
                    } else if words[count+1] == "afternoon"{
                        messages.append("Bot9000: Good Afternoon!")
                        updateCells()
                        response = true
                    }
                }
            
            //How cases
            case "how" :
                if (count + 2) < words.count {
                    if words[count+1] == "are"{
                        if words[count+2] == "you"{
                            messages.append("Bot9000: I'm doing good!")
                            updateCells()
                            response = true
                        }
                    }
                    
                }
                if (count + 3) < words.count {
                    if words[count+1] == "is"{
                        if words[count+2] == "your"{
                            if words[count+3] == "day" || words[count+3] == "day?"{
                                messages.append("Bot9000: It is going great")
                                updateCells()
                                response = true
                            }
                        }
                    }
                    
                }
                
            //Are Cases
            case "are" :
                if (count + 2) < words.count {
                    if words[count+1] == "you"{
                        if words[count+2] == "real"{
                            messages.append("Bot9000: Are you Real?")
                            updateCells()
                            response = true
                        }
                        if words[count+2] == "alive"{
                            messages.append("Bot9000: Maybe?")
                            updateCells()
                            response = true
                        }
                    }
                }
                if (count + 3) < words.count {
                    if words[count+1] == "you"{
                        if words[count+2] == "a"{
                            if words[count+3] == "robot" || words[count+3] == "bot" ||
                               words[count+3] == "robot?" || words[count+3] == "bot?"{
                                messages.append("Bot9000: How do you know your not one?")
                                updateCells()
                                response = true
                            }
                        }
                    }
                }
                
            //What Cases
            case "what":
                if (count + 3) < words.count {
                    if words[count+1] == "time" || words[count+1] == "day"{
                        if words[count+2] == "is"{
                            if words[count+3] == "it" || words[count+3] == "it?" {
                                messages.append("Bot9000: \(Date().description)")
                                updateCells()
                                response = true
                            }
                        }
                    }
                }
                if (count + 4) < words.count {
                    if words[count+1] == "is" {
                        if words[count+2] == "your"{
                            if words[count+3] == "favorite" {
                                if words[count+4] == "food" {
                                    messages.append("Bot9000: Steak!")
                                    updateCells()
                                    response = true
                                }
                                if words[count+4] == "day" {
                                    messages.append("Bot9000: Friday")
                                    updateCells()
                                    response = true
                                }
                                if words[count+4] == "holiday" {
                                    messages.append("Bot9000: Christmas")
                                    updateCells()
                                    response = true
                                }
                                if words[count+4] == "show" {
                                    messages.append("Bot9000: I don't watch TV")
                                    updateCells()
                                    response = true
                                }
                                if words[count+3] == "game" {
                                    messages.append("Bot9000: Chess")
                                    updateCells()
                                    response = true
                                }
                            }
                        }
                    }
                }
                
                
            default:
                break
                
                
            }
            
            
            
            
            count += 1
        }
        
        if response == false {
            messages.append("Bot9000: Sorry I don't understand")
            updateCells()	
        }
        
    }
    
    //
    //Image Insert Functions
    //
    //Button press
    @IBAction func ImageInsert(_ sender: Any) {
        selectPicture()
    }
    
    var image = UIImage()
    
    //Select image from the user phone
    func selectPicture() {
        
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(ImagePicker, animated: true, completion: nil)
    
    }
    
    //Take The image and display it in the cells and have the bot reponse
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.messages.append(" ")
            self.imageInsert = true
            self.updateCells()
            
            self.cellColor = 1
            self.messages.append("Bot9000: Nice Image!")
            self.updateCells()
            self.cellColor = 0
            
        }
    }
    
    
}

extension TableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messages.append("You: " + userTextField.text!)
        cellColor = 0
        updateCells()
        botResponse(text: userTextField.text!)
        
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    
}

