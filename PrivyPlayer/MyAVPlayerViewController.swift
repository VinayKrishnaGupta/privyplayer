//
//  MyAVPlayerViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 31/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import GoogleMobileAds

class MyAVPlayerViewController: AVPlayerViewController {
    public var videoURLfromHome = String()
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
     
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-1687791729093117/8134087614"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let videoURL:URL = URL(string: videoURLfromHome)!
        //let playerItem = CachingPlayerItem(url: videoURL)
        let avAsset = AVURLAsset(url: videoURL as URL, options: nil)
        
        let playerItem : AVPlayerItem = AVPlayerItem(asset: avAsset)
        
        let myplayer = AVPlayer(playerItem: playerItem)
        if #available(iOS 10.0, *) {
            myplayer.automaticallyWaitsToMinimizeStalling = false
        } else {
            // Fallback on earlier versions
        }
        
        myplayer.allowsExternalPlayback = true
        self.player = myplayer
        self.player?.play()
        let fullscreenheight : CGFloat = 5;
        
        if #available(iOS 11.0, *) {
            if ((UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height)! < fullscreenheight) {
                
            }
        } else {
            // Fallback on earlier versions
        }
       
        
        
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: -50),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
