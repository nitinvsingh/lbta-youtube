//
//  Video.swift
//  Youtube
//
//  Created by Nitin Singh on 22/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import Foundation

struct Video: Decodable {
    var thumbnailImageName: String?
    var title: String?
    var views: UInt?
    var duration: Int?
    var channel: Channel?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case views = "number_of_views"
        case thumbnailImageName = "thumbnail_image_name"
        case duration = "duration"
        case channel = "channel"
    }
    
}

struct Channel: Decodable {
    var name: String?
    var profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case profileImage = "profile_image_name"
    }
}
