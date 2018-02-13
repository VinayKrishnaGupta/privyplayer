//
//  ASPVideoViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 12/02/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import ASPVideoPlayer
import AVFoundation
import AVKit


class ASPVideoViewController: UIViewController {
    @IBOutlet var VideoPlayer: ASPVideoPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let videoURL : URL = URL(string:"https://gig.gs/videos/360p/231461289.mp4")!
        VideoPlayer.videoURLs = [videoURL]
        VideoPlayer.gravity = .aspectFill
        VideoPlayer.shouldLoop = false

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {


    }

    override func viewWillDisappear(_ animated: Bool) {
        VideoPlayer.videoPlayerControls.pause()
    }

    @IBAction func fullScreenButton(_ sender: UIButton) {
        VideoPlayer.videoPlayerControls.pause()
        let VideoString : String = "https://gig.gs/videos/360p/231461289.mp4"
        self.playvideo1(VideoURL: VideoString)
        
    }

    func playvideo1(VideoURL:String) {



        let videoURL:URL = URL(string: VideoURL)!
        let avAsset = AVURLAsset(url: videoURL as URL, options: nil)

        let playerItem : AVPlayerItem = AVPlayerItem(asset: avAsset)

        let player = AVPlayer(playerItem: playerItem)
        if #available(iOS 10.0, *) {
            player.automaticallyWaitsToMinimizeStalling = false
        } else {
            // Fallback on earlier versions
        }

        player.allowsExternalPlayback = true
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()




    }
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
