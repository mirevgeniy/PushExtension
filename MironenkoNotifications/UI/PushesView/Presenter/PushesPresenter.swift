//
//  PushesPresenter.swift
//  MironenkoNotifications
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import Foundation

class PushesPresenter {

    weak var view: PushesViewProtocol?;
    var pushes: [MIRPush]?
    let dateFormatter: DateFormatter?;
    
    init(view: PushesViewProtocol) {
        self.view = view;
        self.pushes = Service.sharedManager.getPushes();
        
        self.dateFormatter = DateFormatter();
        self.dateFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        Service.sharedManager.dataUpdated = { [weak self] in
            
            self?.view?.willUpdateData();
            self?.pushes = Service.sharedManager.getPushes();
            self?.view?.didUpdateData();
        }
    }
    
    // MARK: Data Source methods
    
    func getItemsCount() -> Int {
        return self.pushes?.count ?? 0;
    }
    
    func getPushTitleForIndex(_ index: Int) -> String {
        
        guard let pushes = self.pushes, index < pushes.count else {
            return "";
        }
        
        let push = pushes[index];
        
        if push.isSilent {
            return "Silent Push";
        }
        
        if (push.titleText?.count == 0) {
            return "No title";
        }
        
        return push.titleText ?? "";
    }
    
    func getPushBodyValuesForIndex(_ index: Int) -> String {
        
        guard let pushes = self.pushes, index < pushes.count else {
            return "";
        }
        
        let push = pushes[index];
        
        var bodyString = "";
        
        if let date = push.receivedDate, let dateString = self.dateFormatter?.string(from: date) {
            bodyString.append(dateString);
        }
        
        if (push.isSilent) {
            bodyString.append("\nReceived:\(push.receivedNumber) Computed:\(push.computedNumber)")
        }
        
        return bodyString;
    }
}
