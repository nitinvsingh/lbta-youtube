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
    
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> Void) {
        fetchResourceFromURLString("\(baseURL)/home.json", completion: completion)
    }
    
    func fetchTrendingVideos(completion: @escaping ([Video]) -> Void) {
        fetchResourceFromURLString("\(baseURL)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionVideos(completion: @escaping ([Video]) -> Void) {
        fetchResourceFromURLString("\(baseURL)/subscriptions.json", completion: completion)
    }
    
    private func fetchResourceFromURLString(_ urlString: String, completion: @escaping ([Video]) -> ()) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            guard err == nil else { return }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let videos = try decoder.decode([Video].self, from: data)
                completion(videos)
                
//                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                var videos = [Video]()
//                for dictionary in json as! [[String : AnyObject]] {
//                    let video = Video()
//                    video.title = dictionary["title"] as? String
//                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//                    let channel = Channel()
//                    let channelDictionary = dictionary["channel"] as! [String : AnyObject]
//                    channel.name = channelDictionary["name"] as? String
//                    channel.profileImage = channelDictionary["profile_image_name"] as? String
//                    video.channel = channel
//                    videos.append(video)
//                }
//                completion(videos)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            }.resume()
    }
    
    
}
