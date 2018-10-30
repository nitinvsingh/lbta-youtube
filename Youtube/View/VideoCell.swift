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
            guard let _video = video else { return }
            if let thumbnailURL = _video.thumbnailImageName {
                thumbnail.loadImageUsingURLString(thumbnailURL)
            }
            if let profileImageURL = _video.channel?.profileImage {
                profile.loadImageUsingURLString(profileImageURL)
            }
            subtitle.text = _video.channel?.name
            if let views = _video.views {
                if let _ = self.subtitle.text {
                    self.subtitle.text += " • "
                }
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                subtitle.text += numberFormatter.string(from: NSNumber(value: views))!
            }
            if let uploadDate = _video.uploaded {
                if let _ = self.subtitle.text {
                    self.subtitle.text += " • "
                }
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                subtitle.text += dateFormatter.string(from: uploadDate)
            }
            if let title = _video.title {
                self.title.text = title
                // Title label height calculation for the video
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let boundingRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [.font : UIFont.systemFont(ofSize: 14)], context: nil)
                titleHeight.constant = boundingRect.size.height > 20 ? 44 : 20
            }
            
        }
    }
    
    let thumbnail: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profile: CustomImageView = {
        let imageView = CustomImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    private lazy var titleHeight: NSLayoutConstraint = {
        return NSLayoutConstraint(item: title, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
    }()
    override func setupViews() {
        addSubview(thumbnail)
        addSubview(profile)
        addSubview(title)
        addSubview(subtitle)
        addSubview(separator)
        
        addConstraintsWith(format: "H:|-16-[v0]-16-|", on: thumbnail)
        addConstraintsWith(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", on: thumbnail, profile, separator)
        addConstraintsWith(format: "H:|-16-[v0(44)]-8-[v1]-16-|", on: profile, title)
        addConstraintsWith(format: "H:|[v0]|", on: separator)
        
        // Title constraints
        addConstraint(NSLayoutConstraint(item: title, attribute: .leading, relatedBy: .equal, toItem: profile, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: thumbnail, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: title, attribute: .trailing, relatedBy: .equal, toItem: thumbnail, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(titleHeight)
        
        //Subtitle constraints
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .leading, relatedBy: .equal, toItem: profile, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .trailing, relatedBy: .equal, toItem: thumbnail, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
}
