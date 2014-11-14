//
//  ViewController2.swift
//  PT1
//
//  Created by Noah Ludescher on 13.11.14.
//  Copyright (c) 2014 Noah Ludescher. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    
    
    
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var dateField: UITextField!

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDestination(){
        
        var query = PFQuery(className:"GameScore")
        query.getObjectInBackgroundWithId("Ou4W6HrUHK") {
            (destination: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
            }
            else {
               // gameScore["cheatMode"] = true
                // gameScore["score"] = 1339
                //gameScore.incrementKey("score", byAmount: -1)
                destination["playerName"] = self.destinationField.text
                destination["dueDate"] = self.dateField.text
                destination.saveInBackground()
                
            }
        }
    }
    
    
    func pushIt(pushTexttransfer:String){
        let pushText:String = pushTexttransfer
        let data = NSDictionary(objects: [pushText, "cheering.caf"], forKeys: ["alert", "sound"])
        var push = PFPush()
        push.setChannel("global")
        push.setData(data)
        push .sendPushInBackground()
    }
    
    
    @IBAction func addPerson(sender: UIButton) {
        updateDestination()
        pushIt("Noah ist in \(self.destinationField.text)")
       self .dismissViewControllerAnimated(true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
