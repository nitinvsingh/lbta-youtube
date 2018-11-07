//
//  TrendingCell.swift
//  Youtube
//
//  Created by Nitin Singh on 07/11/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.shared.fetchTrendingVideos { videos in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
