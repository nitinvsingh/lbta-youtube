//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Nitin Singh on 08/11/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayer: UIView {
    
    var isPlaying = false
    var avPlayer: AVPlayer?
    
    let controlContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let spinner: UIActivityIndicatorView = {
        let _spinner = UIActivityIndicatorView(style: .white)
        _spinner.translatesAutoresizingMaskIntoConstraints = false
        return _spinner
    }()
    
    lazy var playPause: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let played: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let duration: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.thumbTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleSliderDragged), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupPlayerView()
        
        controlContainer.frame = frame
        addSubview(controlContainer)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.0]
        gradientLayer.frame = bounds
        controlContainer.layer.addSublayer(gradientLayer)
        
        controlContainer.addSubview(spinner)
        controlContainer.addSubview(playPause)
        
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        playPause.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPause.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPause.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPause.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlContainer.addSubview(duration)
        duration.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        duration.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        duration.widthAnchor.constraint(equalToConstant: 50).isActive = true
        duration.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlContainer.addSubview(played)
        played.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        played.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        played.widthAnchor.constraint(equalToConstant: 50).isActive = true
        played.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlContainer.addSubview(slider)
        slider.rightAnchor.constraint(equalTo: duration.leftAnchor).isActive = true
        slider.leftAnchor.constraint(equalTo: played.rightAnchor).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        slider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPlayerView() {
        if let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726") {
            avPlayer = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: avPlayer)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            avPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            let interval = CMTime(seconds: 1, preferredTimescale: 2)
            avPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] progress in
                let seconds = progress.seconds
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                self?.played.text = minutesText + ":" + secondsText
                if let totalDuration = self?.avPlayer?.currentItem?.duration.seconds {
                    self?.slider.value = Float(seconds / totalDuration)
                }
            })
            avPlayer?.play()
        }
    }
    
    @objc func handleSliderDragged() {
        if let duration = avPlayer?.currentItem?.duration {
            let timeValue = duration.seconds * Double(slider.value)
            let seekTime = CMTime(seconds: timeValue, preferredTimescale: 1)
            avPlayer?.seek(to: seekTime, completionHandler: { completed in
                //
            })
        }
    }
    
    @objc func togglePlayPause() {
        if isPlaying {
            avPlayer?.pause()
            playPause.setImage(UIImage(named: "play"), for: .normal)
        } else {
            avPlayer?.play()
            playPause.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            spinner.stopAnimating()
            controlContainer.backgroundColor = .clear
            playPause.isHidden = false
            isPlaying = true
            if let avDuration = avPlayer?.currentItem?.duration {
                let seconds = avDuration.seconds
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                duration.text = "\(minutesText):\(secondsText)"
            }
        }
    }
}

class VideoLauncher: NSObject {

    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView()
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            keyWindow.addSubview(view)
            
            // VideoPlayer view
            let height = keyWindow.frame.width * 9 / 16
            let videoFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayer = VideoPlayer(frame: videoFrame)
            
            view.addSubview(videoPlayer)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { _ in
                // Below method is deprecated. Find an alternate
                UIApplication.shared.setStatusBarHidden(true, with: .slide)
                
            }
        }
    }
    
}
