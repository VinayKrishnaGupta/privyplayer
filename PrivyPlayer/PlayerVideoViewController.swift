//
//  PlayerVideoViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 23/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import ASPVideoPlayer

class PlayerVideoViewController: UIViewController {
let videoPlayer = ASPVideoPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//        let videoURL = Bundle.main.url(forResource: "https://gig.gs/videos/360p/9514810031.mp4", withExtension: "mp4")
//
//        videoPlayer.videoURL = videoURL
//
//        videoPlayer.readyToPlayVideo = {
//
//            self.videoPlayer.playVideo()
//            print("Video has been successfully loaded and can be played.")
//        }
//
//        videoPlayer.startedVideo = {
//            print("Video has started playing.")
//        }
//        videoPlayer.frame = self.view.bounds
//        self.view.addSubview(videoPlayer)
//        videoPlayer.playVideo()
//

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let testVideoURL = URL(string: "http://gig.gs/videos/Angreji%20Wali%20Madam%20by%20Kulwinder%20Billa%20Dr%20Zeus%20Shipra%20Goyal.mp4")
        let firstVideoURL = URL(string: "http://gig.gs/videos/720p/4798310032_lowest.mp4")
        let secondVideoURL = URL(string: "https://gig.gs/videos/720p/9514810031.mp4")
        
        videoPlayer.videoURLs = [testVideoURL!, firstVideoURL!, secondVideoURL!]
        
        videoPlayer.gravity = .aspectFit
        
        videoPlayer.shouldLoop = true
        videoPlayer.frame = self.view.bounds
        videoPlayer.backgroundColor = UIColor.black
        
        self.view.addSubview(videoPlayer)
        
//        let videoURL = NSURL(string: "https://gig.gs/videos/360p/9514810031.mp4")
//        let playerAV = AVPlayer(url: videoURL! as URL)
//
//
//        let playerLayerAV = AVPlayerLayer(player: playerAV)
//        playerLayerAV.frame = self.view.bounds
//
//        self.view.layer.addSublayer(playerLayerAV)
//        playerAV.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
