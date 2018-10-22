//
//  VideoCell.swift
//  Youtube
//
//  Created by Nitin Singh on 20/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            if let thumbnailImage = video?.thumbnailImageName {
                thumbnail.image = UIImage(named: thumbnailImage)
            }
            title.text = video?.title
            if let profileImage = video?.channel?.profileImage {
                profile.image = UIImage(named: profileImage)
            }
            subtitle.text = video?.channel?.name
            if let views = video?.views {
                if let _ = self.subtitle.text {
                    self.subtitle.text += " • "
                }
                let numberFormatter = NumberFormatter()
                numberFormatter.alwaysShowsDecimalSeparator = true
                subtitle.text += numberFormatter.string(from: NSNumber(value: views))!
            }
            if let uploadDate = video?.uploaded {
                if let _ = self.subtitle.text {
                    self.subtitle.text += " • "
                }
                subtitle.text += String(uploadDate.timeIntervalSinceNow)
            }
            
        }
    }
    
    let thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profile: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        addSubview(thumbnail)
        addSubview(profile)
        addSubview(title)
        addSubview(subtitle)
        addSubview(separator)
        
        addConstraintsWith(format: "H:|-16-[v0]-16-|", on: thumbnail)
        addConstraintsWith(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", on: thumbnail, profile, separator)
        addConstraintsWith(format: "H:|-16-[v0(44)]-8-[v1]-16-|", on: profile, title)
        addConstraintsWith(format: "H:|[v0]|", on: separator)
        
        // Title constraints
        addConstraint(NSLayoutConstraint(item: title, attribute: .leading, relatedBy: .equal, toItem: profile, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: thumbnail, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: title, attribute: .trailing, relatedBy: .equal, toItem: thumbnail, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: title, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //Subtitle constraints
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .leading, relatedBy: .equal, toItem: profile, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .trailing, relatedBy: .equal, toItem: thumbnail, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
}
