//
//  ViewController.swift
//  Notify
//
//  Created by Roydon Jeffrey on 1/31/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Request User Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
            //Check for access
            if granted {
                print("Notification access allowed")
            }else {
                print(error?.localizedDescription as Any)
            }
        }
       
    }

    //To send notification in 5 mins
    @IBAction func notify(_ sender: UIButton) {
        
        //Function call
        scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("Successfully scheduled notification")
            }else {
                print("Scheduled notification failed")
            }
        }
        
    }
    
    //To schedule the notification
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) -> ()) {
        
        //An instance of the notification content
        let notif = UNMutableNotificationContent()
        
        //Notification messages
        notif.title = "Awesome Notification"
        notif.subtitle = "Let's check em out"
        notif.body = "The new notification options in iOS 10 are sweeeeetttttt!!"
        
        //To trigger the notification
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        //To make the request
        let request = UNNotificationRequest(identifier: "newNotify", content: notif, trigger: notifTrigger)
        
        //Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            
            //Check if error occured
            if error != nil {
                print(error.debugDescription)
                completion(false)
                
            }else {
                completion(true)
            }
        }
    }
}

