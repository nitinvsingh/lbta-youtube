//
//  HomeController.swift
//  Youtube
//
//  Created by Cogitate Technology Solution on 18/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    var videos: [Video] = {
        var kanye = Channel()
        kanye.name = "KanyeIsTheBestChannel"
        kanye.profileImage = "kanye_profile"
        
        let blankSpace = Video()
        blankSpace.thumbnailImageName = "taylor_swift_blank_space"
        blankSpace.title = "Taylor Swift - Blank Space"
        blankSpace.views = 239843093
        blankSpace.channel = kanye
        
        let badBlood = Video()
        badBlood.thumbnailImageName = "taylor_swift_bad_blood"
        badBlood.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        badBlood.views = 579894934
        badBlood.channel = kanye
        
        return [blankSpace, badBlood]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 20)
        title.text = "Home"
        
        navigationItem.titleView = title
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupNavBarMenu()
        setupMenuBar()
    }
    
    func setupNavBarMenu() {
        let moreIcon = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let more = UIBarButtonItem(image: moreIcon, style: .plain, target: self, action: #selector(handleMore))
        
        let searchIcon = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let search = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(handleSearch))
        
        navigationItem.rightBarButtonItems = [more, search]
    }
    
    func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWith(format: "H:|[v0]|", on: menuBar)
        view.addConstraintsWith(format: "V:|[v0(50)]", on: menuBar)
    }
    
    @objc func handleMore() {
        
    }
    
    @objc func handleSearch() {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
