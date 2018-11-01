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
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor(r: 230, g: 32, b: 31)
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        view.addConstraintsWith(format: "H:|[v0]|", on: redView)
        view.addConstraintsWith(format: "V:[v0(50)]", on: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWith(format: "H:|[v0]|", on: menuBar)
        view.addConstraintsWith(format: "V:[v0(50)]", on: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    func fetchVideos() {
        ApiService.shared.fetchVideos { videos in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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
