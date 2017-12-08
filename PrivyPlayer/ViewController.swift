//
//  ViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 06/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionview: UICollectionView!
 
    let Videocontroller = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        self.navigationItem.title = "Privy Player"
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])

      //  let VideoURL = storage.reference(forURL: "gs://mshmshtv-6e148.appspot.com/Feem __ .mp4")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.playvideo()
    }
    
    
    
    func playvideo() {
        
        
        let videoURL:URL = URL(string: "http://mshmsh.tv/videos/HaanikaarakBapu%20Dangal%20AamirKhan%20Pritam%20AmitabhB%20Sarwar%26SartazKhan%20NewSong2017%20YouTube(360p).mp4")!
        let player = AVPlayer(url: videoURL)
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


}

