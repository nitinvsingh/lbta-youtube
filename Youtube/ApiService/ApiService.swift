//
//  ApiService.swift
//  Youtube
//
//  Created by Cogitate Technology Solution on 01/11/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let shared = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> Void) {
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            guard err == nil else { return }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                var videos = [Video]()
                for dictionary in json as! [[String : AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channel = Channel()
                    let channelDictionary = dictionary["channel"] as! [String : AnyObject]
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImage = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    videos.append(video)
                }
                completion(videos)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            }.resume()
    }
    
}
