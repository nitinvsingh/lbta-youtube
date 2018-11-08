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
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            }.resume()
    }
    
    
}
