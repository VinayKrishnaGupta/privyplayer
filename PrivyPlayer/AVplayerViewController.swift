//
//  AVplayerViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 29/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import AVKit


class AVplayerViewController: UIViewController {
    public var VideoURL = String()
    @IBOutlet var videoPlayerView: UIView!
    let playerController = AVplayerViewController()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.playvideo1(VideoURL: VideoURL)
    }
    func playvideo1(VideoURL:String)
    {
        let videoURL = NSURL(string: VideoURL)
        let playerAV = AVPlayer(url: videoURL! as URL)
        let playerLayerAV = AVPlayerLayer(player: playerAV)
        playerLayerAV.frame = self.videoPlayerView.frame
        self.view.layer.addSublayer(playerLayerAV)
        
        playerAV.play()
        
        
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
