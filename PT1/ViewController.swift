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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.queryFromGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    func queryFromGame(){
        name1 = ""
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
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    @IBAction func addPerson(sender: UIButton) {
        self.queryFromGame()

    }
    
}

