//
//  Video.swift
//  Youtube
//
//  Created by Nitin Singh on 22/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import Foundation

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var views: UInt?
    var uploaded: Date?
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImage: String?
}
