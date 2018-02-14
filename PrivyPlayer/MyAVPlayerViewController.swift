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
     
       bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
//        //ProductionID
//       // bannerView.adUnitID = "ca-app-pub-1687791729093117/8134087614"
//        //TestID
       bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
       bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView2(bannerView)

        
        
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

        
        
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
       self.view.addSubview(bannerView)

      //  self.view.layer.addSublayer(bannerView.layer)

        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .bottom, relatedBy: .equal,
                                              toItem: bottomLayoutGuide, attribute: .bottom, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1, constant: 0))

    }

    func addBannerViewToView2(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bannerView)

        //  self.view.layer.addSublayer(bannerView.layer)

        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .bottom, relatedBy: .equal,
                                              toItem: bottomLayoutGuide, attribute: .bottom, multiplier: 1, constant: -105))
        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1, constant: 0))

    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
//
//             bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
//             bannerView.load(GADRequest())
//         //

             self.bannerView.removeFromSuperview()
           
            addBannerViewToView(bannerView)

           // self.view.sendSubview(toBack: bannerView)

        } else {

             self.bannerView.removeFromSuperview()
             addBannerViewToView2(bannerView)
            print("Portrait")
        }
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
