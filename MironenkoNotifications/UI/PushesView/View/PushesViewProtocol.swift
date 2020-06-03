//
//  PushesViewProtocol.swift
//  MironenkoNotifications
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import Foundation

@objc protocol PushesViewProtocol {
    
    func willUpdateData();
    func didUpdateData();
    
}
