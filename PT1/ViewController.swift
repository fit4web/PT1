//
//  ViewController.swift
//  PT1
//
//  Created by Noah Ludescher on 09.11.14.
//  Copyright (c) 2014 Noah Ludescher. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController  {
    

    var alleObjecte:NSMutableArray! = NSMutableArray()
    var name1 = ""
    var name2:String = ""
    var switch1 = 1
    
    
    
    @IBOutlet weak var textfeld: UITextView!
    
    @IBOutlet weak var setNameField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.queryFromGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUserScore(){
        
    var query = PFQuery(className:"GameScore")
    query.getObjectInBackgroundWithId("Ou4W6HrUHK") {
    (gameScore: PFObject!, error: NSError!) -> Void in
        if error != nil {
            NSLog("%@", error)
        } else {
            gameScore["cheatMode"] = true
           // gameScore["score"] = 1339
            gameScore.incrementKey("score", byAmount: -1)
            gameScore["playerName"] = self.setNameField.text
            gameScore.saveInBackground()
        }
    }
    }
    

    func queryFromGame(){
        println("queryFromGame")
        var query:PFQuery = PFQuery(className: "GameScore")
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!) -> Void in
            
            if error == nil {
                for object in objects {
                    println("queryFromGame-FOR-object")
                    let singleObject:PFObject = object as PFObject
                    self.alleObjecte.addObject(singleObject)
                    
                }
            }
            
            for tableItem in self.alleObjecte {
                let score = "score"
                var scorevalue:Int = tableItem[score] as Int
                self.name1 += tableItem["playerName"] as String
                self.name1 += " mit "
                self.name1 += "\(scorevalue) \n"
                
                
                
            }
            self.textfeld.text = self.name1
            self.name1 = ""
            self.name2 = ""
            
            self.alleObjecte.removeAllObjects()
        }
    }
    
    @IBAction func addPerson(sender: UIButton) {
        self.updateUserScore()
        sleep(10)
        println("nach der pause")
        self.queryFromGame()


    }
    
    
    @IBAction func closeKeyBoard(sender: UIButton) {
        self.setNameField.resignFirstResponder()
    }
    
}

