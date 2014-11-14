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
    
   func unloadNotify() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        println("deinit")
    }
    
            //  NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterForeground", name:UIApplicationWillEnterForegroundNotification, object: nil)
    

    var alleObjecte:NSMutableArray! = NSMutableArray()
    
    
    
    @IBOutlet weak var textfeld: UITextView?
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unloadNotify()
        println("viewDidDisaAppear")

    }
    
    
    
    override func viewDidAppear(animated: Bool ) {
        super.viewDidAppear(animated)
        //Load Notification Listener for "APP opens a 2nd time

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOFReceivedNotication",   name:UIApplicationWillEnterForegroundNotification, object: nil)
        
        //Load Notification Listener for "APP got a Notification about Changes"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodOFReceivedNotication",   name:"didReceiveRemoteNotification", object: nil)
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
        var name1:String = ""

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
              
                name1 += tableItem["playerName"] as String
                name1 += " bis "
                name1 += tableItem["dueDate"] as String
            }
            
            
            self.textfeld?.text = name1
            name1 = ""
            
            self.alleObjecte.removeAllObjects()
        }
    }

    
        
    @IBAction func closeKeyBoard(sender: UIButton) {
    }
    
    //delegates and Selectors
    
    
    func methodOFReceivedNotication(){
        self.queryFromGame()
    }

    
}

