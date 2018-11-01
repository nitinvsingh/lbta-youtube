//
//  MenuBar.swift
//  Youtube
//
//  Created by Nitin Singh on 21/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let menuImages = ["home", "trending", "subscriptions", "account"]
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 230, g: 32, b: 31)
        cv.register(MenuCell.self, forCellWithReuseIdentifier: "cellId")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let selectionBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    var selectionBarLeftConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(collectionView)
        
        addConstraintsWith(format: "H:|[v0]|", on: collectionView)
        addConstraintsWith(format: "V:|[v0]|", on: collectionView)
        
        let home = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: home, animated: false, scrollPosition: .left)
        
        addSubview(selectionBar)
        setupSelectionBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSelectionBar() {
        selectionBarLeftConstraint = selectionBar.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 0)
        selectionBarLeftConstraint?.isActive = true
        selectionBar.bottomAnchor.constraint(equalToSystemSpacingBelow: self.bottomAnchor, multiplier: 0).isActive = true
        selectionBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        selectionBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: menuImages[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor(r: 91, g: 14, b: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let barX = (frame.width / 4) * CGFloat(indexPath.item)
        selectionBarLeftConstraint?.constant = barX
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            toggleMenu(isSelected)
        }
    }
    
    
    private func toggleMenu(_ selectionState: Bool) {
        imageView.tintColor = selectionState ? .white : UIColor(r: 91, g: 14, b: 13)
    }
    
    override func setupViews() {
        addSubview(imageView)
        
        addConstraintsWith(format: "H:[v0(28)]", on: imageView)
        addConstraintsWith(format: "V:[v0(28)]", on: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
