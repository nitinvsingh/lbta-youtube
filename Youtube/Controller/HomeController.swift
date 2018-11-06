//
//  HomeController.swift
//  Youtube
//
//  Created by Cogitate Technology Solution on 18/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    var videos: [Video]?
    
    let container = "container"
    
//    let settings = SettingsLauncher()
    lazy var settings: SettingsController = {
        let controller = SettingsController()
        controller.homeController = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 20)
        title.text = "Home"
        
        navigationItem.titleView = title
        
        setupNavBarMenu()
        setupMenuBar()
        setupCollectionView()
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
    
    func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: container)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func setTitleForIndex(_ index: Int) {
        if let title = navigationItem.titleView as? UILabel {
            title.text = "  \(titles[index])"
        }
    }
    
    @objc func handleMore() {
        settings.show()
        settings.homeController = self
    }
    
    @objc func handleSearch() {
        scrollToMenu(atIndex: 2)
    }
    
    func scrollToMenu(atIndex index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        setTitleForIndex(index)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int((targetContentOffset.move().x / view.frame.width).rounded())
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        setTitleForIndex(index)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: container, for: indexPath) as! FeedCell
        cell.videos = videos
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.selectionBarLeftConstraint?.constant = scrollView.contentOffset.x / 4
    }
}


// Dummy controller for the settings screen.
extension HomeController {
    func showControllerForSetting(_ setting: Setting) {
        let dummy = UIViewController()
        dummy.title = setting.name?.rawValue
        dummy.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummy, animated: true)
    }
}
