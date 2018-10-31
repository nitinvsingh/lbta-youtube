//
//  Setting.swift
//  Youtube
//
//  Created by Cogitate Technology Solution on 30/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: SettingName?
    let icon: String?
    
    init(name: SettingName, icon: String) {
        self.name = name
        self.icon = icon
    }
    
}

enum SettingName: String {
    case account = "Switch Account"
    case help = "Help"
    case feedback = "Send Feedback"
    case privacyTerms = "Terms & privacy policy"
    case appSettings = "Settings"
    case cancel = "Cancel"
}
