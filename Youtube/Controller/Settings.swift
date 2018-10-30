//
//  Settings.swift
//  Youtube
//
//  Created by Nitin Singh on 30/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let backdrop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        view.frame = UIApplication.shared.keyWindow?.frame ?? CGRect.zero
        return view
    }()
    
    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cv.backgroundColor = .white
        return cv
    }()
    
    let settings : [Setting] = {
        let setting = Setting(name: "Settings", icon: "settings")
        let privacy = Setting(name: "Terms & privacy policy", icon: "privacy")
        let feedback = Setting(name: "Send Feedback", icon: "feedback")
        let help = Setting(name: "Help", icon: "help")
        let account = Setting(name: "Switch Account", icon: "switch_account")
        let cancel = Setting(name: "Cancel", icon: "cancel")
        return [setting, privacy, feedback, help, account, cancel]
    }()

    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func show() {
        if let window = UIApplication.shared.keyWindow {
            backdrop.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
            window.addSubview(backdrop)
            window.addSubview(collectionView)
            
            // CollectionView position calculation
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backdrop.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.5) {
            self.backdrop.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
}
