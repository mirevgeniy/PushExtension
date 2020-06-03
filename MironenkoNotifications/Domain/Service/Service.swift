//
//  Service.swift
//  MironenkoNotifications
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import Foundation

class Service {
    
    static let sharedManager = Service()
    private init() {}
    var dataUpdated: (() -> ())?
    
    // MARK: Application Strate
    
    func setApplicationSateActive() {
        // update ui
        
        if let dataUpdated = Service.sharedManager.dataUpdated {
            dataUpdated();
        }
    }
    
    // MARK: Push Notifications
    func sendDevicePushToken(deviceToken: Data) {
        
        // send token
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined();
        print("Device token: \(token)");
    }
    
    
    // MARK: Database
    func getPushes() -> [MIRPush]? {
        
        let entities = CoreDataManager.sharedManager.fetchAllPushes();
        return entities;
    }
    
    func getPushesCount() -> Int {
        let count = CoreDataManager.sharedManager.fetchAllPushesCount();
        return count;
    }
    
    func insertPushWithText(text: String,
                            recievedDate: Date,
                            recievedNumber: Int,
                            computedNumber: Int,
                            isSilent: Bool,
                            complitation: @escaping(MIRPush?, NSError?) -> ()) {
        
        
        let entities = CoreDataManager.sharedManager.insertPushWithText(text: text,
                                                                      recievedDate: recievedDate,
                                                                      recievedNumber: recievedNumber,
                                                                      computedNumber: computedNumber,
                                                                      isSilent: isSilent);
        
        if let unwrappedEntity = entities {
            complitation(unwrappedEntity, nil);
        } else {
            complitation(nil, nil);
        }
    }
}
