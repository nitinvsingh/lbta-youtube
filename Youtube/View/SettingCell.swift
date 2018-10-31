//
//  SettingCell.swift
//  Youtube
//
//  Created by Cogitate Technology Solution on 30/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting: Setting? {
        didSet {
            if let setting = setting {
                name.text = setting.name?.rawValue
                if let imageName = setting.icon {
                    icon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                }
            }
        }
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            name.textColor = isHighlighted ? .white : .black
            icon.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(icon)
        addSubview(name)
        
        // Constraints
        addConstraintsWith(format: "H:|-8-[v0(30)]-8-[v1]|", on: icon, name)
        addConstraintsWith(format: "V:|[v0]|", on: name)
        addConstraintsWith(format: "V:[v0(30)]", on: icon)
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
