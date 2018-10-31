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
    
    var videos: [Video]?
    
//    let settings = SettingsLauncher()
    lazy var settings: SettingsController = {
        let controller = SettingsController()
        controller.homeController = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchVideos()
        
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
    
    func fetchVideos() {
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else {
            return
        }
        URLSession.shared.dataTask(with: url) {[weak self] data, resp, err in
            guard err == nil else { return }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                self?.videos = [Video]()
                for dictionary in json as! [[String : AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channel = Channel()
                    let channelDictionary = dictionary["channel"] as! [String : AnyObject]
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImage = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    
                    self?.videos?.append(video)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            
            
            }.resume()
    }
    
    @objc func handleMore() {
        settings.show()
        settings.homeController = self
    }
    
    @objc func handleSearch() {
        
    }
    
    func showControllerForSetting(_ setting: Setting) {
        let dummy = UIViewController()
        dummy.title = setting.name?.rawValue
        dummy.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummy, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
