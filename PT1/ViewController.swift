//
//  ViewController.swift
//  PT1
//
//  Created by Noah Ludescher on 09.11.14.
//  Copyright (c) 2014 Noah Ludescher. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITextFieldDelegate {
    

    var alleObjecte:NSMutableArray! = NSMutableArray()
    var name1 = ""
    
    
    
    @IBOutlet weak var textfeld: UITextView!
    
    
    
    
    override func viewDidAppear(animated: Bool ) {
        super.viewDidAppear(animated)
        self.queryFromGame()
        println("viewDidAppear")
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.queryFromGame()
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

       

    func queryFromGame(){
        println("queryfromGame")
        var query:PFQuery = PFQuery(className: "GameScore")
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!) -> Void in
            
            if error == nil {
                for object in objects {
                    let singleObject:PFObject = object as PFObject
                    self.alleObjecte.addObject(singleObject)
                    
                }
            }
            
            for tableItem in self.alleObjecte {
              
                self.name1 += tableItem["playerName"] as String
                self.name1 += " bis "
                self.name1 += tableItem["dueDate"] as String
            }
            
            
            self.textfeld.text = self.name1
            self.name1 = ""
            
            self.alleObjecte.removeAllObjects()
        }
    }

    
        
    @IBAction func closeKeyBoard(sender: UIButton) {
        self.textfeld.resignFirstResponder()
    }
    
    //delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
}

