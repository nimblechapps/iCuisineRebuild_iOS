//
//  ViewController.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 24/06/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import UIKit

class CustomProvider : UIActivityItemProvider {
    
    var facebookMessage : String!
    var twitterMessage : String!
    var emailMessage : String!
    
    init(placeholderItem: String, facebookMessage : String, twitterMessage : String, emailMessage : String) {
        super.init(placeholderItem: placeholderItem)
        self.facebookMessage = facebookMessage
        self.twitterMessage = twitterMessage
        self.emailMessage = emailMessage
        
    }
    override var item: Any{
        
        if self.activityType == UIActivityType.postToFacebook{
        return facebookMessage
        }
        else if self.activityType == UIActivityType.postToTwitter{
            return twitterMessage
        }
        else if self.activityType == UIActivityType.mail{
            return emailMessage
        }
        else{
            return "hello world"
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        
        

    }
    
    @IBAction func buttonTapped(){
        
        BLEHelper.sharedInstance.scanPeripherals()
        
        
        
        
//        let customProvider : CustomProvider = CustomProvider(placeholderItem: "Placeholder" , facebookMessage: "Facebook" , twitterMessage: "Twitter" , emailMessage:"Email")
//        let url : NSURL  = NSURL(string: "http://www.icuisine.com")!
//        let image : UIImage = UIImage(named: "Spatula")!
//        
//        let customItems  = [customProvider, url, image]
//        
//        let activityViewController = UIActivityViewController(activityItems: customItems, applicationActivities: nil)
//        
//        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.assignToContact, UIActivityType.saveToCameraRoll, UIActivityType.addToReadingList, UIActivityType.postToFlickr, UIActivityType.postToVimeo, UIActivityType.airDrop]
//        
//        self.present(activityViewController, animated: true, completion: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

