//
//  Setting.swift
//  Youtube
//
//  Created by Cogitate Technology Solution on 30/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: String?
    let icon: String?
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
}
