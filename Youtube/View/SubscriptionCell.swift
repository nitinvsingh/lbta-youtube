//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by Nitin Singh on 07/11/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.shared.fetchSubscriptionVideos { videos in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()                
            }
        }
    }
}
