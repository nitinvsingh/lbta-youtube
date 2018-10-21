//
//  VideoCell.swift
//  Youtube
//
//  Created by Nitin Singh on 20/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift - Blank Space"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = .lightGray
        textView.text = "TaylorSwiftVEVO • 1,604,684,687 • 2 years ago"
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
        addSubview(thumbnailImage)
        addSubview(profileImage)
        addSubview(title)
        addSubview(subtitle)
        addSubview(separator)
        
        addConstraintsWith(format: "H:|-16-[v0]-16-|", on: thumbnailImage)
        addConstraintsWith(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", on: thumbnailImage, profileImage, separator)
        addConstraintsWith(format: "H:|-16-[v0(44)]-8-[v1]-16-|", on: profileImage, title)
        addConstraintsWith(format: "H:|[v0]|", on: separator)
        
        // Title constraints
        addConstraint(NSLayoutConstraint(item: title, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: thumbnailImage, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: title, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImage, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: title, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //Subtitle constraints
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .trailing, relatedBy: .equal, toItem: thumbnailImage, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .top, relatedBy: .equal, toItem: title, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
}
