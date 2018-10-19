//
//  ViewController.swift
//  Youtube
//
//  Created by Cogitate Technology Solution on 18/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Home"
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class VideoCell: UICollectionViewCell {
    
    let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitle: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
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
        addConstraint(NSLayoutConstraint(item: subtitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
    }
    
}

extension UIView {
    func addConstraintsWith(format: String, on views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            viewsDictionary["v" + String(index)] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
