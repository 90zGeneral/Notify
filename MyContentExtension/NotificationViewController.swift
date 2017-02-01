//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Roydon Jeffrey on 1/31/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        //Grab the first item in the attachments array
        guard let attachment = notification.request.content.attachments.first else { return }
        
        //Protection outside of the app sandbox
        if attachment.url.startAccessingSecurityScopedResource() {
            
            //Grab the image data from the attachment
            let imageData = try? Data.init(contentsOf: attachment.url)
            
            //Check if image data exist and assign it to the imageView
            if let img = imageData {
                imageView.image = UIImage(data: img)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        if response.actionIdentifier == "fistBump" {
            completion(.dismissAndForwardAction)
            
        }else if response.actionIdentifier == "dismiss" {
            completion(.dismissAndForwardAction)
        }
    }

}
