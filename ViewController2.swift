//
//  ViewController2.swift
//  PT1
//
//  Created by Noah Ludescher on 13.11.14.
//  Copyright (c) 2014 Noah Ludescher. All rights reserved.
//

import UIKit
import CoreData

class ViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    //CoreData implementation
   let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    @IBOutlet weak var alleDestinationen: UITextView!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    var alleObjecteausIataAirports:NSMutableArray! = NSMutableArray()
    var iataCodes:[String] = [] as Array


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        queryFromIataAirports()
        println("viewWillAppear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
 //       updateDestination()
        pushIt("Noah ist in \(self.destinationField.text)")
       self .dismissViewControllerAnimated(true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func queryFromIataAirports(){
        var stringforIata:String = ""
        println("queryFromIataAirports")
        //Query
        var query:PFQuery = PFQuery(className: "IataAirports")
        let letters:NSArray = ["a","b","c","d","e","f","g","h","i","j","k","l"]
       
        query.whereKey("iataCode", hasPrefix: "Z")
        query.limit = 1000

//        // [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
//        let alleObjecteausIataAirports = query.findObjects() as Array
//        for Items in alleObjecteausIataAirports {
//            var itemStringArray:String = Items["iataCode"] as String
//        iataCodes.append(itemStringArray)
//        }
//        var destinations2 = "\(self.iataCodes)" as String
//        self.alleDestinationen.text = destinations2
         query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!) -> Void in

            if error == nil {
                for object in objects {
                    let singleObject:PFObject = object as PFObject
                    self.alleObjecteausIataAirports.addObject(singleObject)
                    
                }
            }

            //println(self.alleObjecteausIataAirports)
            for tableItem in self.alleObjecteausIataAirports {
//
              //  stringforIata = tableItem["iataCode"] as String
              //  stringforIata += " bis "
              //  stringforIata += tableItem["destination"] as String
//
               // println(stringforIata)
            
            var newItemCountry = tableItem["country"] as String
            var newItemDestination = tableItem["destination"] as String
            var newItemIataCode = tableItem["iataCode"] as String
            var newItemLHAirport:Bool = false
                
                if (tableItem["lhAirport"]! == nil) {
                    var    newItemLhAirport:Bool = false
                }
                else {
                    var    newItemLhAirport:Bool = tableItem["lhAirport"] as Bool
                }
                
            var newItemCreatedAt = tableItem.createdAt as NSDate
            var newItemID = tableItem.objectId as String
                
             println(newItemID)
                
            self.pushDataToCoreData(newItemID, country: newItemCountry, destination: newItemDestination, iataCode: newItemIataCode, lhAirport: newItemLHAirport, createdAt: newItemCreatedAt)

//                self.iataCodes.append("\(stringforIata)")
//                stringforIata = ""
////                    addObject(stringforIata)
//
//            }
//            var destinations2 = "\(self.iataCodes)" as String
//            self.alleDestinationen.text = destinations2
//            println(self.iataCodes)
//            
//            //self.alleObjecte.removeAllObjects()
        }
        }
    }

    
    func pushDataToCoreData(objectId:String, country:String, destination:String, iataCode:String, lhAirport:Bool, createdAt:NSDate){
        
        var newItem = NSEntityDescription.insertNewObjectForEntityForName("IataAirports", inManagedObjectContext: self.context!) as IataAirports
        
//        newItem.objectId = objectId
//        newItem.country = country
//        newItem.destination = destination
//        newItem.iataCode = iataCode
//        newItem.lhAirport = lhAirport
//        newItem.createdAt = createdAt
        
        newItem.objectId = "test1"
        newItem.country = "Test1C"
        newItem.destination = "Test1D"
        newItem.iataCode = "Test1I"
        newItem.lhAirport = false
     //   newItem.createdAt =

    
    }
        
    
    
    //Delegates
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      //  println("picker-numberOfComponentsInPickerView")
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       // println("picker-numberOfRowsInComponent")

        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
     //   println("picker - titleForRow")

               return "1"

        //return "\(arr[row])"
    }

    
}
