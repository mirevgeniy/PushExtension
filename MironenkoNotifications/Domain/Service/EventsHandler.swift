//
//  EventsListener.swift
//  MironenkoNotifications
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import Foundation
import UIKit

class EventsHandler {
    
    static let push_custom_key = "yourCustomKey";
    
    static let sharedManager = EventsHandler()
    private init() {}
    
    // MARK: Push Notifications Lifecycle
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Service.sharedManager.sendDevicePushToken(deviceToken: deviceToken);
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // handle error
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        guard let customValue = userInfo[EventsHandler.push_custom_key] as? String else {
            completionHandler(.noData);
            return;
        }
        
        print(customValue);
        guard let recievedNumber = Int(customValue) else {
            completionHandler(.noData);
            return;
        }
        
        // insert new data
        DispatchQueue.main.async {
            
            Service.sharedManager.insertPushWithText(text: "Silent Push", recievedDate: Date(), recievedNumber: recievedNumber, computedNumber: (recievedNumber * 2), isSilent: true) { (push, error) in
                // handle error
            }
            
            completionHandler(.newData);
        }
    }
    
    func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        // to find some correct way to handle that from notification service
    }

    // MARK: Application Lifecycle
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        Service.sharedManager.setApplicationSateActive();
    }
    
}
