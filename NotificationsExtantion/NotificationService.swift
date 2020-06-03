//
//  NotificationService.swift
//  NotificationsExtantion
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import UserNotifications
import CoreData

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        let pushesCount = Service.sharedManager.getPushesCount() + 1;
        let pushTitle = self.pushTitleStringWithCount(count: pushesCount);
        
        Service.sharedManager.insertPushWithText(text: pushTitle, recievedDate: Date(), recievedNumber: 0, computedNumber: 0, isSilent: false) { (push, error) in
            // handle error here
        };
        
        if let bestAttemptContent = bestAttemptContent {
            
            bestAttemptContent.title = pushTitle;
            bestAttemptContent.body = "Body text from notification service"
            contentHandler(bestAttemptContent);
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    func pushTitleStringWithCount(count: Int) -> String {
        return "You have \(count) messages";
    }

}
