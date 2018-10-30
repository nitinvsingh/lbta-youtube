//
//  CustomImageView.swift
//  Youtube
//
//  Created by Nitin Singh on 30/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var urlString: String?
    
    func loadImageUsingURLString(_ urlString: String) {
        self.urlString = urlString
        // Check if image available in cache
        
        // Image available - Use from cache
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = cachedImage
            return
        }
        
        // Image not available - download via network
        guard let imageURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard error == nil else { return }
            guard let data = data, let imageToCache = UIImage(data: data) else { return }
            imageCache.setObject(imageToCache, forKey: NSString(string: urlString))
            if self.urlString! == urlString {
                DispatchQueue.main.async {
                    self.image = imageToCache
                }
            }
            }.resume()
    }
    
}
